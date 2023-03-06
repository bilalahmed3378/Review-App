//
//  LoginSwicher.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct LoginSwitcher: View {
    @State var isUserLoggedIn : Bool = false
    
    @State var isLoginView : Bool = false


    var body: some View {
        ZStack{
            if(self.isUserLoggedIn){
                MainTabContainer(isUserLoggedIn: self.$isUserLoggedIn)
            }
            else{
                if(self.isLoginView){
                    SignupScreen(pushToSignup: self.$isLoginView)
                }
                else{
                    LoginScreen(pushToSignup: self.$isLoginView)
                }
            }
        }
    }
}
