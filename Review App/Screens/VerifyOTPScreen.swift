//
//  VerifyOTPScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct VerifyOTPScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ViewModel()
    @State var isFocused = false

    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 15
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    var body: some View {
        ZStack{
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
                    Text("We have sent you an OTP with 05 digits, please check your email and confirm it’s you.")
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
                            
                        }
                        
                        
                        TextField("", text: $viewModel.otpField)
                            .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                            .disabled(viewModel.isTextFieldDisabled)
                            .textContentType(.oneTimeCode)
                            .autocapitalization(.none)
                            .foregroundColor(.clear)
                            .accentColor(.clear)
                            .background(Color.clear)
                            .onChange(of: self.viewModel.otpField) { newValue in
                                self.viewModel.otpField = newValue.limit(limit : 5)
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
              

                BlueButton(lable: "Confirm")
                    .padding(.top,40)
               
                
                Spacer()
            }
            .padding(.leading,20)
            .padding(.trailing,20)
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
}



class ViewModel: ObservableObject {
    
    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 6
                    //                  otpField.last?.isNumber ?? true else {
                    //                otpField = oldValue
            else{ return
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
    
    
    
    @Published var borderColor: Color = .black
    @Published var isTextFieldDisabled = false
    var successCompletionHandler: (()->())?
    
    @Published var showResendText = false
    
}

