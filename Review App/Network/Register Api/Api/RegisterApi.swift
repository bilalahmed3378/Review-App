//
//  RegisterApi.swift
//  MeccaFitness
//
//  Created by CodeCue on 09/04/2022.
//

import Foundation
import MultipartForm

class RegisterApi : ObservableObject{
        //MARK: - Published Variables
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var registerSuccessful = false
    @Published var apiResponse :  RegisterResponseModel?
    @Published var emailAlreadyInUse = false

    

    

    
    func registerUser(name : String  , email : String , password : String){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.registerSuccessful = false
        self.emailAlreadyInUse = false
        self.isApiCallDone = false
        
            //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.signup ) else {return}
        
        
        let formToRequest = MultipartForm(parts: [
            MultipartForm.Part(name: "name", value: name),
            MultipartForm.Part(name: "email", value: email),
            MultipartForm.Part(name: "password", value: password),
          
        ])
        
        print(formToRequest.contentType)
        
        let data : Data = "name=\(name)&email=\(email)&password=\(password)".data(using: .utf8)!

        
        
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
                print("Got register response succesfully.....")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(RegisterResponseModel.self, from: data)
                DispatchQueue.main.async {
                    self.apiResponse = main
                    self.isApiCallSuccessful  = true
                    if(main.message == "Signed Up Successfully"){
                     
                            self.registerSuccessful = true
                        
                     
                    }
                    else if(main.message == "ValidationError"){
                        self.registerSuccessful = false
                        print("register invalid data")
                    }
                    else if(main.message == "There was a duplicate key error"){
                        self.emailAlreadyInUse = true
                        print("Email Already exsist")
                    }
                    else{
                        self.registerSuccessful = false
                        print("else register fail")
                    }
                    self.isLoading = false
                }
            }catch{  // if error
                print(error)
                DispatchQueue.main.async {
                    print("in aa deconging error of register api")
                    self.isApiCallDone = true
                    self.apiResponse = nil
                    self.isApiCallSuccessful  = true
                    self.registerSuccessful = false
                    self.isLoading = false
                }
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON)
        }
        
        task.resume()
    }
    
 
    
}
