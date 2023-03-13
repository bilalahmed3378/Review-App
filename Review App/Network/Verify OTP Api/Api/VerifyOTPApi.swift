//
//  VerifyOTPApi.swift
//  Review App
//
//  Created by Bilal Ahmed on 27/02/2023.
//

import Foundation


class VerifyOTPApi : ObservableObject{
    
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var dataRetrivedSuccessfully = false
    @Published var apiResponse :  VerifyOTPResponseModel?
    @Published var incorrectOTP = false

    
    
    
    
    func verifyOTP(otp : String, email : String){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.dataRetrivedSuccessfully = false
        self.isApiCallDone = false
        
        //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.verifyResetPasswordOTP + "/\(email)/\(otp)" ) else {return}
        
        print(url)
        
//        let token = AppData().getBearerToken()
        
        
        //Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(NetworkConfig.secretKey, forHTTPHeaderField: "secretKey")
        
        
        
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
                print("Got verify password otp response succesfully.....")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(VerifyOTPResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.apiResponse = main
                    self.isApiCallSuccessful  = true
                    
                    if(main.message == "OTP Verified"){
                        
                        guard let response = response as? HTTPURLResponse else {
                            
                            print("didn't get token")
                            
                            return }
                        
                        if (!(response.value(forHTTPHeaderField: "Bearer")!).isEmpty){
                            
                            AppData().saveBearerToken(bearerToken: response.value(forHTTPHeaderField: "Bearer")!)
                                                        
                        }

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

