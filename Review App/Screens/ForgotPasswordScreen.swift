//
//  ForgotPasswordScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @Environment(\.presentationMode) var presentationMode
    

    @StateObject var setNewPasswordApi : NewPasswordApi = NewPasswordApi()

    @State var showToast : Bool = false
    
    
    @State var toastMessage : String = ""

    @State var passwordConfirm  = ""
    @State var password  = ""
    @State var showPassword : Bool = false
    @State var showConfirmPassword : Bool = false
    

    @State var toHome : Bool = false

    
    


    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(edges: .bottom)

            NavigationLink(destination: LoginSwitcher(), isActive: self.$toHome){
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
                    Text("Password")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top,20)
               
                HStack{
                    Text("Reset and confirm new password")
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
                            Text("New password")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        if(self.showPassword){
                            TextField("at least 8 characters", text: self.$password)
                                .padding(15)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                .overlay(HStack{
                                    Spacer()
                                    Button(action: {
                                      
                                            self.showPassword.toggle()
                                        
                                    }){
                                        Image(systemName: "eye.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(AppColors.textColor)
                                            
                                    }
                                    .padding(.trailing,10)
                                })
                        }
                        else{
                            SecureField("at least 8 characters", text: self.$password)
                                .padding(15.8)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                .overlay(HStack{
                                    Spacer()
                                    Button(action: {
                                      
                                            self.showPassword.toggle()
                                        
                                    }){
                                        Image(systemName: "eye.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(AppColors.textColor)
                                            
                                    }
                                    .padding(.trailing,10)
                                })
                        }
                       
                        
                    }
                    .padding(.top,15)
                    
                    //password field
                    VStack{
                        HStack{
                            Text("Confirm new Password")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                            
                           
                            
                        }
                        
                        if(self.showConfirmPassword){
                            TextField("at least 8 characters", text: self.$passwordConfirm)
                                .padding(15)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                .overlay(HStack{
                                    Spacer()
                                    Button(action: {
                                      
                                            self.showConfirmPassword.toggle()
                                        
                                    }){
                                        Image(systemName: "eye.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(AppColors.textColor)
                                            
                                    }
                                    .padding(.trailing,10)
                                })
                        }
                        else{
                            SecureField("at least 8 characters", text: self.$passwordConfirm)
                                .padding(15.8)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                .overlay(HStack{
                                    Spacer()
                                    Button(action: {
                                      
                                            self.showConfirmPassword.toggle()
                                        
                                    }){
                                        Image(systemName: "eye.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(AppColors.textColor)
                                            
                                    }
                                    .padding(.trailing,10)
                                })
                        }
                       
                    }
                    .padding(.top,15)
                }
              
                
                if(self.setNewPasswordApi.isLoading){
                    ProgressView()
                        .padding(20)
                        .onDisappear{
                            if(self.setNewPasswordApi.isApiCallDone && self.setNewPasswordApi.isApiCallSuccessful){
                                
                                if(self.setNewPasswordApi.dataRetrivedSuccessfully){
                                    self.toastMessage = "Password Updated"
                                    self.showToast = true
                                    
                                    self.toHome = true
                                }
                                else{
                                    self.toastMessage = "Password could not be updated"
                                    self.showToast = true
                                }
                                
                            }
                            else if(self.setNewPasswordApi.isApiCallDone && (!self.setNewPasswordApi.isApiCallSuccessful)){
                                self.toastMessage = "Unable to access internet. Please check you internet connection and try again."
                                self.showToast = true
                            }
                        }
                }

                else{
                    Button(action: {
                        
                        if (self.password.isEmpty){
                            
                            self.showToast = true
                            self.toastMessage = "Please enter password."
                            
                        }
                        
                        else if !(self.password == self.passwordConfirm){
                            
                            self.showToast = true
                            self.toastMessage = "Passwords do not match."
                            
                            
                        }
                        
                        else if !(self.isValidPassword()){
                            self.toastMessage = "Password must be at least 8 characters long and must contains one special charater and number."
                            self.showToast = true
                        }
                        
                        
                        else{
                            
                            self.setNewPasswordApi.password(password: self.password)
                            
                        }
                      
                    }, label: {
                        BlueButton(lable: "Confirm")
                            .padding(.top,30)
                            
                       
                    })
                    .disabled(showToast == true)
                }
               
              
                   
                
               
                
                Spacer()
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            .padding(.top,10)
            .padding(.bottom,10)
            
            if(self.showToast){
                Toast(isShowing: self.$showToast, message: self.toastMessage)
            }


        }
        .navigationBarHidden(true)
    }
    
    func isValidPassword() -> Bool {
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = self.password.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
        
    }
}

