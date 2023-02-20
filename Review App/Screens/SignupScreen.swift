//
//  SignupScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct SignupScreen: View {
    
    @State var name  = ""
    @State var email  = ""
    @State var password  = ""
    @State var isChecked : Bool = false
    @Binding var pushToSignup : Bool

    
    init (pushToSignup : Binding<Bool>){
        self._pushToSignup = pushToSignup
        
    }

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                //screen name
                HStack{
                    Text("Sign up")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    Spacer()
                }
               
                HStack{
                    Text("Start turning your ideas into reality")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    Spacer()
                }
                .padding(.top,5)
                
                //input fields
                Group{
                    //name field
                    VStack{
                        HStack{
                            Text("Name")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        TextField("Enter your name", text: self.$name)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                            .onChange(of: self.name) { newValue in
                                self.name = newValue.limit(limit : 50)
                            }
                    }
                    .padding(.top,30)
                    
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
                    .padding(.top,20)
                    
                    //password field
                    VStack{
                        HStack{
                            Text("Password")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        TextField("at least 8 characters", text: self.$password)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                            .onChange(of: self.password) { newValue in
                                self.password = newValue.limit(limit : 50)
                            }
                    }
                    .padding(.top,20)
                }
                HStack{
                    if(self.isChecked){
                        Image(systemName: "squareshape.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.black)
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
                    
                    Text("I agree with Terms and Privacy")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_14)
                    
                    Spacer()

                }
                .padding(.top,20)

                BlueButton(lable: "Get Started")
                    .padding(.top,20)
                
                Divider()
                    .padding(.top,20)
                
                HStack{
                    Text("Already have an account?")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    
                   Button(action: {
                       self.pushToSignup = false
                   }, label: {
                       Text("Login")
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

