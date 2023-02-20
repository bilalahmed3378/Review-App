//
//  LoginScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct LoginScreen: View {
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
                                ForgotPasswordScreen()
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
                    if(self.isChecked){
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(AppColors.appPrimaryColor)
                            .onTapGesture{
                                self.isChecked = false
                            }
                    }
                    else{
                        Image(systemName: "squareshape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.gray)
                            .onTapGesture{
                                self.isChecked = true
                            }
                    }
                    
                    Text("Remember me")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_14)
                    
                    Spacer()

                }
                .padding(.top,20)

                BlueButton(lable: "Log in")
                    .padding(.top,40)
                
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
        }
        .navigationBarHidden(true)
    }
}

