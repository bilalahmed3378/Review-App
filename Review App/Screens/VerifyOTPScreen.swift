//
//  VerifyOTPScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct VerifyOTPScreen: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var verifyOTP = VerifyOTPApi()
    
    @State private var otp: String = ""


    let buttons = [
           ["1", "2", "3"],
           ["4", "5", "6"],
           ["7", "8", "9"],
           ["", "0", "<"]
       ]

    @State var showToast : Bool = false
    @State var toastMessage : String = ""

    @State var toEmailConfirmationScreen : Bool = false


    let  email : String

    @StateObject var viewModel = ViewModel()
    @State var isFocused = false

         let textBoxWidth = UIScreen.main.bounds.width / 8
         let textBoxHeight = UIScreen.main.bounds.width / 8
         let spaceBetweenBoxes: CGFloat = 10
         let paddingOfBox: CGFloat = 1
         var textFieldOriginalWidth: CGFloat {
             (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
         }




    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(edges: .bottom)

            NavigationLink(destination: ForgotPasswordScreen(), isActive: self.$toEmailConfirmationScreen){
                EmptyView()
            }


            VStack{

                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()

                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    })

                    Spacer()
                }
                .padding(.top,10)





                //screen name
                HStack{
                    Text("OTP")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top,30)

                HStack{
                    Text("We have sent you an OTP with 06 digits, please check your email and confirm it???s you.")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    Spacer()
                }
                .padding(.top,5)


                //textfields
                Group{

                    ZStack {
                        
                        HStack (spacing: spaceBetweenBoxes){
                            
                            otpText(text: viewModel.otp1)
                            otpText(text: viewModel.otp2)
                            otpText(text: viewModel.otp3)
                            otpText(text: viewModel.otp4)
                            otpText(text: viewModel.otp5)
                            otpText(text: viewModel.otp6)

                            
                        }
                        
                        
                        TextField("", text: $viewModel.otpField)
                            .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                            .disabled(viewModel.isTextFieldDisabled)
                            .textContentType(.oneTimeCode)
                            .autocapitalization(.none)
                            .foregroundColor(.clear)
                            .accentColor(.clear)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                            .onChange(of: self.viewModel.otpField) { newValue in
                                self.viewModel.otpField = newValue.limit(limit : 6)
                            }
                    }
                    .padding(.top)
                    .padding(.bottom)




                }

                HStack{
                    Spacer()
                    Text("Resend")
                        .foregroundColor(AppColors.appPrimaryColor)
                        .font(AppFonts.ceraPro_16)
                }
                .padding(.top,20)

                if(self.verifyOTP.isLoading){

                    HStack{

                        Spacer()

                        ProgressView()
                            .padding()

                        Spacer()

                    }.onDisappear {

                        if(self.verifyOTP.isApiCallDone && self.verifyOTP.isApiCallSuccessful){

                            if(self.verifyOTP.dataRetrivedSuccessfully){

                                self.showToast = true
                                self.toastMessage = "otp verified successfully"
                                self.toEmailConfirmationScreen = true

                            }


                            else if(self.verifyOTP.apiResponse?.message == "Incorrect OTP"){


                                self.showToast = true
                                self.toastMessage = "incorrect otp"


                            }

                            else if(self.verifyOTP.apiResponse?.message == "OTP Expired."){

                                self.showToast = true
                                self.toastMessage = "otp expired"


                            }

                            else{

                                self.showToast = true
                                self.toastMessage = "something went wrong"


                            }


                        }

                        else if(self.verifyOTP.isApiCallDone && (!self.verifyOTP.isApiCallSuccessful)){

                            self.showToast = true
                            self.toastMessage = "Unable to access internet. Please check you internet connection and try again."

                        }
                    }
                }

                else{

                    Button(action: {


                        if !(viewModel.otpField.isEmpty){

                            self.verifyOTP.verifyOTP(otp: viewModel.otpField, email: self.email)

                            print(viewModel.otpField)
                            print(email)

                        }


                    }, label: {


                        BlueButton(lable: "Confirm")
                            .padding(.top,40)

                    })

                }
                
                ForEach(buttons, id: \.self) { row in
                               HStack {
                                   ForEach(row, id: \.self) { button in
                                       Button(action: {
                                           self.buttonTapped(button: button)
                                       }, label: {
                                           Text(button)
                                               .font(.title)
                                       })
                                       .frame(width: 80, height: 80)
                                       .background(Color.gray.opacity(0.2))
                                       .cornerRadius(8)
                                   }
                               }
                           }
                .padding(.top,20)



                Spacer()
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            .padding(.top,10)
            .padding(.bottom,10)


            if(showToast){
                Toast(isShowing: self.$showToast, message: self.toastMessage)
            }



        }
        .navigationBarHidden(true)
        
        
    }

    private func otpText(text: String) -> some View {

             return Text(text)
                 .font(.title)
                 .frame(width: textBoxWidth, height: textBoxHeight)
                 .background(VStack{
                   Spacer()
                   RoundedRectangle(cornerRadius: 1)
                         .frame(height: 0.5)
                  })
                 .padding(paddingOfBox)
         }
    
    func buttonTapped(button: String) {
           switch button {
           case "<":
               viewModel.otpField = String(viewModel.otpField.dropLast())
           default:
               viewModel.otpField += button
           }
       }
}



class ViewModel: ObservableObject {

    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    var otp1: String {
        guard otpField.count >= 1 else {
            return ""
        }
        return String(Array(otpField)[0])
    }
    var otp2: String {
        guard otpField.count >= 2 else {
            return ""
        }
        return String(Array(otpField)[1])
    }
    var otp3: String {
        guard otpField.count >= 3 else {
            return ""
        }
        return String(Array(otpField)[2])
    }
    var otp4: String {
        guard otpField.count >= 4 else {
            return ""
        }
        return String(Array(otpField)[3])
    }

    var otp5: String {
        guard otpField.count >= 5 else {
            return ""
        }
        return String(Array(otpField)[4])
    }

    var otp6: String {
        guard otpField.count >= 6 else {
            return ""
        }
        return String(Array(otpField)[5])
    }

    @Published var borderColor: Color = .black
    @Published var isTextFieldDisabled = false
    var successCompletionHandler: (()->())?

    @Published var showResendText = false

}


struct OTPTextField: View {
    let tag: Int
    @Binding var otp: String

    var body: some View {
        TextField("", text: Binding(
            get: { otpAtIndex(tag) },
            set: { otpUpdate($0, at: tag) }
        ))
        .keyboardType(.numberPad)
        .frame(width: 40, height: 40)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }

    func otpAtIndex(_ index: Int) -> String {
        guard otp.count > index else { return "" }
        let startIndex = otp.index(otp.startIndex, offsetBy: index)
        let endIndex = otp.index(startIndex, offsetBy: 1)
        return String(otp[startIndex..<endIndex])
    }

    func otpUpdate(_ value: String, at index: Int) {
        guard value.count < 2 else { return }
        if value.count == 1 {
            otp.insert(value.first!, at: otp.index(otp.startIndex, offsetBy: index))
        } else {
            otp.remove(at: otp.index(otp.startIndex, offsetBy: index))
        }
    }
}
