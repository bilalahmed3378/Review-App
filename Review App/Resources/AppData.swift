//
//  AppData.swift
//  MeccaFitnessPro
//
//  Created by CodeCue on 11/04/2022.
//

import Foundation


class AppData {
    
    
    
    func appFirstTimeLoaded()->Bool{
        let sharedPrefrences = UserDefaults.standard
        if(sharedPrefrences.object(forKey: Constants.isFirstTimeLoaded)==nil){
            return false
        }
        return sharedPrefrences.bool(forKey: Constants.isFirstTimeLoaded)
    }
    
    func isUserLoggedIn()->Bool{
        let sharedPrefrences = UserDefaults.standard
        if (sharedPrefrences.object(forKey: Constants.userLoggedIn) == nil){
            return false
        }
        return (sharedPrefrences.bool(forKey: Constants.userLoggedIn))
    }
    
    
    func userLoggedIn(){
        UserDefaults.standard.set(true, forKey: Constants.userLoggedIn)
    }
    
    
    func isRememberMe()->Bool{
        let sharedPrefrences = UserDefaults.standard
        if (sharedPrefrences.object(forKey: Constants.rememberMe) == nil){
            return false
        }
        return (sharedPrefrences.bool(forKey: Constants.rememberMe))
    }
    
    
    func setRemeberMe(rememberMe : Bool){
        UserDefaults.standard.set(rememberMe, forKey: Constants.rememberMe)
    }
    
    func getUserPassword()->String{
        let sharedPrefrences = UserDefaults.standard
        if (sharedPrefrences.object(forKey: Constants.userPassword)==nil){
            return ""
        }
        return sharedPrefrences.string(forKey: Constants.userPassword)!
    }
    
    
    func getUserEmail()->String{
        let sharedPrefrences = UserDefaults.standard
        if (sharedPrefrences.object(forKey: Constants.userEmail)==nil){
            return ""
        }
        return sharedPrefrences.string(forKey: Constants.userEmail)!
    }
    

    func saveRememberMeData(email : String , password: String){
        UserDefaults.standard.set(email, forKey: Constants.userEmail)
        UserDefaults.standard.set(password, forKey: Constants.userPassword)
    }
    
    func getUserId()->String{
        let sharedPrefrences = UserDefaults.standard
        if (sharedPrefrences.object(forKey: Constants.userId)==nil){
            return ""
        }
        return sharedPrefrences.string(forKey: Constants.userId)!
    }
    
    func getPhone()->String{
        let sharedPrefrences = UserDefaults.standard
        var phone = ""
        if !(sharedPrefrences.object(forKey: Constants.userPhoneNumber)==nil){
            phone.append(sharedPrefrences.string(forKey: Constants.userPhoneNumber) ?? "")
        }
        return phone
    }
    
    func getUserName()->String{
        let sharedPrefrences = UserDefaults.standard
        var name = ""
        if !(sharedPrefrences.object(forKey: Constants.firstName)==nil){
            name.append(sharedPrefrences.string(forKey: Constants.firstName)!)
        }
        if !(sharedPrefrences.object(forKey: Constants.lastName)==nil){
            name.append(" ")
            name.append(sharedPrefrences.string(forKey: Constants.lastName)!)
        }
        return name
    }
    
    
    func getFirstName()->String{
        let sharedPrefrences = UserDefaults.standard
        var name = ""
        if !(sharedPrefrences.object(forKey: Constants.firstName)==nil){
            name.append(sharedPrefrences.string(forKey: Constants.firstName)!)
        }
        return name
    }
    
    
    
    func getLastName()->String{
        let sharedPrefrences = UserDefaults.standard
        var name = ""
        if !(sharedPrefrences.object(forKey: Constants.lastName)==nil){
            name.append(sharedPrefrences.string(forKey: Constants.lastName)!)
        }
        return name
    }
    
    
    func getGender()->String{
        let sharedPrefrences = UserDefaults.standard
        var gender = ""
        if !(sharedPrefrences.object(forKey: Constants.gender)==nil){
            gender.append(sharedPrefrences.string(forKey: Constants.gender)!)
        }
        return gender
    }
    
    func appIsLoadedForFistTime(){
        UserDefaults.standard.set(true, forKey: Constants.isFirstTimeLoaded)
    }
    
    func saveFcmToken(fcmToken : String){
        UserDefaults.standard.set(fcmToken, forKey: Constants.fcmToken)
    }
    
    func getFcmToken()->String{
        var fcmToken = ""
        let sharedPrefrences = UserDefaults.standard
        if !(sharedPrefrences.object(forKey: Constants.fcmToken) == nil){
            fcmToken = sharedPrefrences.string(forKey: Constants.fcmToken) ?? ""
        }
        return fcmToken
    }
    
    func saveUserId(userId : String){
        UserDefaults.standard.set(userId, forKey: Constants.userId)
    }
    
    
    func saveBearerToken(bearerToken : String){
        UserDefaults.standard.set(bearerToken, forKey: Constants.bearerToken)
    }
    
    
    func getBearerToken()->String{
        if (UserDefaults.standard.object(forKey: Constants.bearerToken) == nil){
            return ""
        }
        else{
            return UserDefaults.standard.string(forKey: Constants.bearerToken) ?? ""
        }
    }
    
    
    func saveUserImage(imageUrl : String){
        UserDefaults.standard.set(imageUrl, forKey: Constants.userImage)
    }
    
    
    func getUserImage()->String{
        if (UserDefaults.standard.object(forKey: Constants.userImage) == nil){
            return ""
        }
        else{
            return UserDefaults.standard.string(forKey: Constants.userImage) ?? ""
        }
    }
    
    
    func saveFirstName(firstName : String){
        UserDefaults.standard.set(firstName, forKey: Constants.firstName)
    }
    
    func saveLastName(lastName : String){
        UserDefaults.standard.set(lastName, forKey: Constants.lastName)
    }
    
    
    func saveUserDesigination(desigination : String){
        UserDefaults.standard.set(desigination, forKey: Constants.userDesigination)
    }
    
    
    func getUserDesigination()->String{
        if (UserDefaults.standard.object(forKey: Constants.userDesigination) == nil){
            return ""
        }
        else{
            return UserDefaults.standard.string(forKey: Constants.userDesigination) ?? ""
        }
    }
    
    
    func isEmailVerfied()->Bool{
        if (UserDefaults.standard.object(forKey: Constants.emailVerfied) == nil){
            return false
        }
        return UserDefaults.standard.bool(forKey: Constants.emailVerfied)
    }
    
    
    func setEmailVerfied(verfied : Bool){
        UserDefaults.standard.set(verfied, forKey: Constants.emailVerfied)
    }
    
    
    
    func logoutTheUser(){
        UserDefaults.standard.removeObject(forKey: Constants.userLoggedIn)
        UserDefaults.standard.removeObject(forKey: Constants.bearerToken)
        UserDefaults.standard.removeObject(forKey: Constants.userId)
        UserDefaults.standard.removeObject(forKey: Constants.firstName)
        UserDefaults.standard.removeObject(forKey: Constants.lastName)
        UserDefaults.standard.removeObject(forKey: Constants.userEmail)
        UserDefaults.standard.removeObject(forKey: Constants.userImage)
        UserDefaults.standard.removeObject(forKey: Constants.userPhoneNumber)
        UserDefaults.standard.removeObject(forKey: Constants.userStore)
        UserDefaults.standard.removeObject(forKey: Constants.emailVerfied)
        UserDefaults.standard.removeObject(forKey: Constants.isProfileSetup)
        UserDefaults.standard.removeObject(forKey: Constants.userPassword)

    }
    
    func saveUserDetails(user : LoginDocsModel){
        UserDefaults.standard.set(user._id, forKey: Constants.userId)
        UserDefaults.standard.set(user.firstname, forKey: Constants.firstName)
        UserDefaults.standard.set(user.lastname, forKey: Constants.lastName)
        UserDefaults.standard.set(user.email, forKey: Constants.userEmail)
      
    }
    
    
    func profileSetup() {
        UserDefaults.standard.set(1, forKey: Constants.isProfileSetup)
        
    }
    
    func isProfileSetup() -> Int{
        if(UserDefaults.standard.object(forKey: Constants.isProfileSetup) != nil){
            return UserDefaults.standard.integer(forKey: Constants.isProfileSetup)
        }
        else{
            return 0
        }
    }
    
//    func saveUserDetails(employee : EmployeProfile){
//        UserDefaults.standard.set(employee.firstname, forKey: Constants.firstName)
//        UserDefaults.standard.set(employee.lastname, forKey: Constants.lastName)
//        UserDefaults.standard.set(employee.email, forKey: Constants.userEmail)
//        UserDefaults.standard.set(employee.image, forKey: Constants.userImage)
//        UserDefaults.standard.set(employee.phone, forKey: Constants.userPhoneNumber)
//        UserDefaults.standard.set(employee.storename, forKey: Constants.userStore)
//    }
    
    func getUserFirstName()->String{
        var name = ""
        let sharedPrefrences = UserDefaults.standard
        if !(sharedPrefrences.object(forKey: Constants.firstName) == nil){
            name = sharedPrefrences.string(forKey: Constants.firstName)!
        }
        return name
    }
    
    
    
    
    
}
