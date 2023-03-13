//
//  SignupScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject var signupApi  = RegisterApi()
    
    @State  var pushToOTP = false


    @State var showToast : Bool = false
    @State var toastMessage : String = ""
    
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
            
            Color.white
                .ignoresSafeArea(edges: .bottom)
            
          

         
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack{
                    
                    Image(uiImage: UIImage(named: AppImages.logoApp)!)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding(.top,5)
                    
                    //screen name
                    HStack{
                        Text("Sign up")
                            .foregroundColor(.black)
                            .font(AppFonts.ceraPro_24)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top,10)
                    
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
                                .autocapitalization(.none)
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
                        
                        NavigationLink(destination: PrivacyPoliceScreen()){
                            Text("I agree with Terms and Privacy")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_14)
                        }
                        
                        
                        Spacer()
                        
                    }
                    .padding(.top,20)
                    
                    if(self.signupApi.isLoading){
                        ProgressView()
                            .padding(20)
                            .onDisappear{
                                if(self.signupApi.isApiCallDone && self.signupApi.isApiCallSuccessful){
                                    
                                    if(self.signupApi.registerSuccessful){
                                        self.pushToSignup = false
                                        
                                    }
                                    else if (self.signupApi.emailAlreadyInUse){
                                        self.toastMessage = "This email already taken. Please try different email."
                                        self.showToast = true
                                    }
                                    
                                }
                                else if(self.signupApi.isApiCallDone && (!self.signupApi.isApiCallSuccessful)){
                                    self.toastMessage = "Unable to access internet. Please check you internet connection and try again."
                                    self.showToast = true
                                }
                                else {
                                    self.toastMessage = "Unable to Signup. Please Try Again"
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
                            else if (self.password.isEmpty){
                                self.toastMessage = "Please enter password"
                                self.showToast = true
                            }
                            else if !(self.isValidPassword()){
                                self.toastMessage = "Password must be at least 8 characters long and must contains one special charater and number."
                                self.showToast = true
                            }
                            else if !(self.isChecked){
                                self.toastMessage = "Please tick the checkbox of terms and conditions"
                                self.showToast = true
                            }
                            
                            
                            
                            else{
                                self.signupApi.registerUser(name: self.name, email: self.email, password: self.password)
                            }
                        }, label: {
                            BlueButton(lable: "Get Started")
                                .padding(.top,20)
                        })
                        
                    }
                    
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
                    
                    
                }
                .padding(.leading,20)
                .padding(.trailing,20)
                .padding(.top,10)
                .padding(.bottom,10)
                }
                .padding(.top,10)
            
            if(showToast){
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
    
    
    
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailTest.evaluate(with: email)
    }
}

