//
//  AddProfileDataApi.swift
//  MeccaFitness
//
//  Created by CodeCue on 11/04/2022.
//

import Foundation
import MultipartForm
import UIKit


class AddProfileApi : ObservableObject{
        //MARK: - Published Variables
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var addedSuccessful = false
    @Published var apiResponse :  AddProfileResponseModel?
    

    

    
    func addUserProfileData(firstname : String , lastname : String , tagline : String , description : String , profileImage : Data , coverImage : Data){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.addedSuccessful = false
        self.isApiCallDone = false
        
            //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.addProfile ) else {return}
        
        let user_id = AppData().getUserId()
        
        var formToRequest = MultipartForm(parts: [
            MultipartForm.Part(name: "firstname", value: firstname),
            MultipartForm.Part(name: "lastname", value: firstname),
            MultipartForm.Part(name: "tagline", value: tagline),
            MultipartForm.Part(name: "description", value: description),
            MultipartForm.Part(name: "profileImage", data: profileImage , filename: "user_image_\(user_id)"),
            MultipartForm.Part(name: "coverImage", data: coverImage , filename: "cover_image_\(user_id)")

          
          
        ])
        
       
        
        let token = AppData().getBearerToken()
        
            //Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(formToRequest.contentType, forHTTPHeaderField: "Content-Type")
        request.setValue(NetworkConfig.secretKey, forHTTPHeaderField: "secretKey")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = formToRequest.bodyData
        
        
        
        
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
                print("Got add profile data response succesfully.....")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(AddProfileResponseModel.self, from: data)
                DispatchQueue.main.async {
                    self.apiResponse = main
                    self.isApiCallSuccessful  = true
                    if(main.message == "Profile Created Successfully"){
                        if(main.docs != nil){
                            self.addedSuccessful = true
                        }
                        else{
                            self.addedSuccessful = false
                            print("register data null")
                        }
                    }
                   
                    self.isLoading = false
                }
            }catch{  // if error
                print(error)
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                    self.apiResponse = nil
                    self.isApiCallSuccessful  = true
                    self.addedSuccessful = false
                    self.isLoading = false
                }
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON)
        }
        
        task.resume()
    }
    
 
    
}

