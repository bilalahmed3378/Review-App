//
//  SendOTPVerifyEmailScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 06/03/2023.
//

import SwiftUI

struct SendOTPVerifyEmailScreen : View {
    @Environment(\.presentationMode) var presentationMode
    

    @StateObject var sendResetPasswordOTPApi : SendOTPVerifyEmailApi = SendOTPVerifyEmailApi()


    @State var email  = ""
    
    @State var showToast : Bool = false
    
    
    @State var toastMessage : String = ""
    
    @State var navigateToOTP : Bool = false
    
    @Binding var isUserLoggedIn : Bool
   
    
    init(isUserLoggedIn : Binding<Bool>){
        self._isUserLoggedIn = isUserLoggedIn
    }


   

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(edges: .bottom)
            
            NavigationLink(destination: VerifyOTPEmailScreen(isUserLoggedIn: self.$isUserLoggedIn), isActive: self.$navigateToOTP){
                EmptyView()
            }

            VStack{
                
                
                //screen name
                HStack{
                    Text("Send OTP to verify your Email")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top,20)
               
              
                
               
                if(self.sendResetPasswordOTPApi.isLoading){
                    ProgressView()
                        .padding(20)
                        .onDisappear{
                            
                                if(self.sendResetPasswordOTPApi.isApiCallDone && self.sendResetPasswordOTPApi.isApiCallSuccessful){
                                    
                                    if(self.sendResetPasswordOTPApi.dataRetrivedSuccessfully){
                                        
                                        self.navigateToOTP = true
                                    }
                                    else{
                                        self.toastMessage = "Unable to send OTP"
                                        self.showToast = true
                                    }
                                    
                                }
                                else if(self.sendResetPasswordOTPApi.isApiCallDone && (!self.sendResetPasswordOTPApi.isApiCallSuccessful)){
                                    self.toastMessage = "Unable to access internet. Please check you internet connection and try again."
                                    self.showToast = true
                                }
                            
                        }
                }

                else{
                    Button(action: {
                        
                      
                            self.sendResetPasswordOTPApi.sendOTP()
                        
                        
                    }, label: {
                        BlueButton(lable: "Send")
                            .padding(.top,30)
                        
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
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailTest.evaluate(with: email)
    }
}


