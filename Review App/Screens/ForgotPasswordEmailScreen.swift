//
//  ForgotPasswordEmailScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 27/02/2023.
//

import SwiftUI

struct ForgotPasswordEmailScreen: View {
    @Environment(\.presentationMode) var presentationMode
    

    @StateObject var sendResetPasswordOTPApi : SendResetPasswordOTPApi = SendResetPasswordOTPApi()


    @State var email  = ""
    
    @State var showToast : Bool = false
    
    
    @State var toastMessage : String = ""
    
    @State var navigateToOTP : Bool = false

   

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(edges: .bottom)
            
            NavigationLink(destination: VerifyOTPScreen(email: self.email), isActive: self.$navigateToOTP){
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
                    Text("Enter your email")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top,20)
               
                HStack{
                    Text("Reset and confirm ")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    Spacer()
                }
                .padding(.top,5)
                
                //input fields
                Group{
                  
                    
                    //password field
                    VStack{
                        HStack{
                            Text("Email")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                     
                            TextField("at least 8 characters", text: self.$email)
                                .padding(15)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                
                      
                       
                        
                    }
                    .padding(.top,15)
                    
                  
                }
              
                if(self.sendResetPasswordOTPApi.isLoading){
                    ProgressView()
                        .padding(20)
                        .onDisappear{
                            
                                if(self.sendResetPasswordOTPApi.isApiCallDone && self.sendResetPasswordOTPApi.isApiCallSuccessful){
                                    
                                    if(self.sendResetPasswordOTPApi.dataRetrivedSuccessfully){
                                        
                                        self.navigateToOTP = true
                                    }
                                    else if (self.sendResetPasswordOTPApi.userNotFound){
                                        self.toastMessage = "User not found. Please try different email."
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
                        
                        if (self.email.isEmpty){
                            self.toastMessage = "Please enter email"
                            self.showToast = true
                        }
                        else if (self.isValidEmail(email: self.email)){
                            self.toastMessage = "Email seems invalid. Please enter valid email address"
                            self.showToast = true
                        }
                        else{
                            self.sendResetPasswordOTPApi.getOTP(email: self.email)
                        }
                        
                    }, label: {
                        BlueButton(lable: "Confirm")
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
