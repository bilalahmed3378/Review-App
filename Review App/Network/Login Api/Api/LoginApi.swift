//
//  LoginApi.swift
//  cars conneted
//
//  Created by Bilal Ahmed on 02/08/2022.
//

import Foundation


class LoginApi : ObservableObject{
    
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var loginSuccessful = false
    @Published var apiResponse :  LoginResponseModel?
    @Published var hasToSetupProfile = false

    

    
    func loginUser(email : String , password : String){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.loginSuccessful = false
        self.isApiCallDone = false
        self.hasToSetupProfile = false

        
            //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.login ) else {return}
        
        
        let data : Data = "email=\(email)&password=\(password)".data(using: .utf8)!

    
            //Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NetworkConfig.secretKey, forHTTPHeaderField: "secretkey")
        request.httpBody = data
        
            //:end
    

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                    self.isApiCallSuccessful=false
                    self.isLoading = false
                }
                return
            }
                //If sucess
            
            
            do{
                print("Got login response succesfully.....")
                
//                guard let response = response as? HTTPURLResponse else { return }
//
//                print(response.)
                
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                
                    self.apiResponse = main
                    self.isApiCallSuccessful = true
                    
                    if(main.message == "Logged In Successfully"){
                        
                        guard let response = response as? HTTPURLResponse else {
                            
                            print("didn't get token")
                            
                            return }
                        
                        if (!(response.value(forHTTPHeaderField: "bearer")!).isEmpty){
                            
                            AppData().saveBearerToken(bearerToken: response.value(forHTTPHeaderField: "bearer")!)
                                                        
                        }
                        
                        self.loginSuccessful = true
                        
                        if(main.docs == nil){

                            self.hasToSetupProfile = true
                            
//                            AppData().saveBearerToken(bearerToken: main.data!.token ?? "")
                           
                        }
                        
                        else{
                            
                            AppData().saveUserDetails(user: main.docs!)
                            
                        }
                       
                    }
                    else{
                        
//                        print("I am hererererererer")
//                        
//                        print(self.isApiCallDone)
//                        print(self.isApiCallSuccessful)

                        self.loginSuccessful = false
                    }
                    self.isLoading = false
                }
            }catch{  // if error
                print(error)
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                    self.apiResponse = nil
                    self.isApiCallSuccessful  = true
                    self.loginSuccessful = false
                    self.isLoading = false
                    self.hasToSetupProfile = false
                }
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON)
            
        }
        
        task.resume()
    }
    
 
    
}


