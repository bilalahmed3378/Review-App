//
//  ForgotPasswordScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @Environment(\.presentationMode) var presentationMode

    @State var passwordConfirm  = ""
    @State var password  = ""
    @State var showPassword : Bool = true
    @State var showConfirmPassword : Bool = true

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(edges: .bottom)


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
              

                NavigationLink(destination: {
                    VerifyOTPScreen()
                }, label: {
                    BlueButton(lable: "Confirm")
                        .padding(.top,30)
                   
                })
               
                
                Spacer()
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            .padding(.top,10)
            .padding(.bottom,10)


        }
        .navigationBarHidden(true)
    }
}

