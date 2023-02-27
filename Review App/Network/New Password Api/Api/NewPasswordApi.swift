//
//  NewPasswordApi.swift
//  Review App
//
//  Created by Bilal Ahmed on 27/02/2023.
//

import Foundation


class NewPasswordApi : ObservableObject{
    
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var dataRetrivedSuccessfully = false
    @Published var apiResponse :  NewPasswordResponseModel?

    
    
    
    
    func password(password : String){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.dataRetrivedSuccessfully = false
        self.isApiCallDone = false
        
        //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.newPassword ) else {return}
        
        
        let token = AppData().getBearerToken()
        
        
        let data : Data = "password=\(password)".data(using: .utf8)!

        
        //Create request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(NetworkConfig.secretKey, forHTTPHeaderField: "secretKey")
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
                print("Got reset password response succesfully.....")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(NewPasswordResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.apiResponse = main
                    self.isApiCallSuccessful  = true
                    
                    if(main.message == "Password Reset Successfully"){
                        
                            self.dataRetrivedSuccessfully = true
                            
                    }
                    
                    else{
                        self.dataRetrivedSuccessfully = false
                    }
                    self.isLoading = false
                }
            }catch{  // if error
                print(error)
                DispatchQueue.main.async {
                    print(error)
                    self.isApiCallDone = true
                    self.apiResponse = nil
                    self.isApiCallSuccessful  = true
                    self.dataRetrivedSuccessfully = false
                    self.isLoading = false
                }
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON)
        }
        
        task.resume()
    }
    
    
    
}


