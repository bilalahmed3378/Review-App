//
//  VerifyOTPEmailScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 06/03/2023.
//




import SwiftUI

struct VerifyOTPEmailScreen : View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ViewOTPModel()
    
    @StateObject var verifyOTP = VerifyOTPEmailApi()

    @State var isFocused = false
    
    @State var showToast : Bool = false
    @State var toastMessage : String = ""
    
    @State var toProfileSeetup : Bool = false

    

    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*5)+(spaceBetweenBoxes*2)+((paddingOfBox*2)*3)
        
    }
    
    @Binding var isUserLoggedIn : Bool
   
    
    init(isUserLoggedIn : Binding<Bool>){
        self._isUserLoggedIn = isUserLoggedIn
    }


    
   

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(edges: .bottom)
            
            NavigationLink(destination: CreateProfileScreen(isUserLoggedIn: self.$isUserLoggedIn), isActive: self.$toProfileSeetup){
                EmptyView()
            }


            VStack{
                
                
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
                                self.toProfileSeetup = true
                                
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
                            
                            self.verifyOTP.verifyOTP(otp: viewModel.otpField)
                            
                            print(viewModel.otpField)
                            
                        }
                        else{
                            self.showToast = true
                            self.toastMessage = "Enter OTP"
                            
                        }
                        
                        
                    }, label: {
                        
                        
                        BlueButton(lable: "Confirm")
                            .padding(.top,40)
                        
                    })
                    
                }
               
                
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
}



class ViewOTPModel: ObservableObject {
    
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

