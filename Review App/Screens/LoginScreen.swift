//
//  LoginScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var loginApi : LoginApi = LoginApi()
    
    @State var remmberMe : Bool = false

    @State var isUserLoggedIn = false
    
    @State var showToast : Bool = false
    @State var toastMessage : String = ""

    @State var toCreatedProfile : Bool = false
    
    @State var toVerifyOTP : Bool = false

    
    @State var name  = ""
    @State var email  = ""
    @State var password  = ""
    @State var isChecked : Bool = false
    @Binding var pushToSignup : Bool
    
    @State var showPassword : Bool = true


    
    init (pushToSignup : Binding<Bool>){
        self._pushToSignup = pushToSignup
        
    }

    var body: some View {
        ZStack{
            
            if !(self.loginApi.hasToSetupProfile){
                
                NavigationLink(destination: MainTabContainer(isUserLoggedIn: self.$isUserLoggedIn), isActive: $isUserLoggedIn){
                    EmptyView()
                }
                
                NavigationLink(destination: SendOTPVerifyEmailScreen(isUserLoggedIn: self.$toVerifyOTP), isActive: $toVerifyOTP){
                    EmptyView()
                }
            }
            
            NavigationLink(destination: CreateProfileScreen(isUserLoggedIn: self.$toCreatedProfile), isActive: self.$toCreatedProfile){
                EmptyView()
            }
            
            Color.white
                .ignoresSafeArea(edges: .bottom)


            VStack{
                Spacer()
                //screen name
                HStack{
                    Text("Log in")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top,10)
               
                HStack{
                    Text("Welcome back! Enter your email and password below to Log in.")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    Spacer()
                }
                .padding(.top,5)
                
                //input fields
                Group{
                  
                    
                    //email field
                    VStack{
                        HStack{
                            Text("Email")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        TextField("Enter your email", text: self.$email)
                            .padding(15)
                            .autocapitalization(.none)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                            .onChange(of: self.email) { newValue in
                                self.email = newValue.limit(limit : 50)
                            }
                    }
                    .padding(.top,30)
                    
                    //password field
                    VStack{
                        HStack{
                            Text("Password")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                            
                            NavigationLink(destination: {
                                ForgotPasswordEmailScreen()
                            }, label: {
                                Text("Forgot password?")
                                    .foregroundColor(AppColors.appPrimaryColor)
                                    .font(AppFonts.ceraPro_16)
                            })
                          
                            
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
                                .onChange(of: self.password) { newValue in
                                    self.password = newValue.limit(limit : 50)
                                }
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
                                        Image(systemName: "eye.slash.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(AppColors.textColor)
                                            
                                    }
                                    .padding(.trailing,10)
                                })
                                .onChange(of: self.password) { newValue in
                                    self.password = newValue.limit(limit : 50)
                                }
                        }
                       
                    }
                    .padding(.top,20)
                }
                HStack{
                    if(self.remmberMe){
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(AppColors.appPrimaryColor)
                            .onTapGesture{
                                self.remmberMe = false
                            }
                    }
                    else{
                        Image(systemName: "squareshape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.gray)
                            .onTapGesture{
                                self.remmberMe = true
                            }
                    }
                    
                    Text("Remember me")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_14)
                    
                    Spacer()

                }
                .padding(.top,20)

                if(self.loginApi.isLoading){
                    ProgressView()
                        .onDisappear{
                           
                           
                           if(self.loginApi.isApiCallDone && self.loginApi.isApiCallSuccessful){
                               
                               
                               if(self.loginApi.loginSuccessful){
                                   
                                   if(self.remmberMe){
                                       AppData().saveRememberMeData(email: self.email, password: self.password)
                                   }
                                   
                                   
                                   if(self.loginApi.apiResponse!.docs!.profileSetup == true && self.loginApi.apiResponse!.docs!.emailVerified == true){
                                       
                                       AppData().setRemeberMe(rememberMe: self.remmberMe)
                                       AppData().saveUserDetails(user: self.loginApi.apiResponse!.docs!)
                                       AppData().userLoggedIn()
                                       self.isUserLoggedIn = true
                                       
                                       
                                   }
                                   else if(self.loginApi.apiResponse!.docs!.profileSetup == false && self.loginApi.apiResponse!.docs!.emailVerified == false){
                                       self.toVerifyOTP = true
                                   }
                                   
                                   else{
                                       
                                       withAnimation{
                                           self.toCreatedProfile = true
                                           
                                       }
                                       
                                   }
                                   
                                   
                               }
                               else{
                                   
                                   
                                   self.toastMessage = "Email or password incorrent"
                                   self.showToast = true
                               }
                           }
                           else if(self.loginApi.isApiCallDone && (!self.loginApi.isApiCallSuccessful)){
                               self.toastMessage = "Unable to access internet. Please check you internet connection and try again."
                               self.showToast = true
                           }
                           
                       }
                }
                else{
                    Button(action: {
                        if(self.email.isEmpty){
                            self.toastMessage = "Please enter email."
                            self.showToast = true
                        }
                        else if(self.password.isEmpty){
                            self.toastMessage = "Please enter password."
                            self.showToast = true
                        }
                        else{
                            
                            self.loginApi.loginUser(email: self.email, password: self.password)
                            
                        }
                    }, label: {
                        BlueButton(lable: "Log in")
                            .padding(.top,40)
                    })
                   
                }
              
                  
                
              
                
                Divider()
                    .padding(.top,20)
                
                HStack{
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    
                    Button(action: {
                        self.pushToSignup = true
                    }, label: {
                        Text("Sign up")
                            .foregroundColor(AppColors.appPrimaryColor)
                            .font(AppFonts.ceraPro_16)
                    })
                   

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
        .onAppear{
            let appData = AppData()
            self.remmberMe = appData.isRememberMe()
            if(self.remmberMe){
                self.email = appData.getUserEmail()
                self.password = appData.getUserPassword()
            }
            
            if (appData.isUserLoggedIn()){
                
                self.isUserLoggedIn = true
            }
            
        }
    }
}

