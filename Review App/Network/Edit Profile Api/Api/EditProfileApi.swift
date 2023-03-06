//
//  EditProfileApi.swift
//  Review App
//
//  Created by Bilal Ahmed on 23/02/2023.
//

import Foundation
import MultipartForm
import UIKit
import SwiftUI


class EditProfileApi : ObservableObject{
    
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var addedSuccessful = false
    @Published var apiResponse :  EditProfileResponseModel?
    
    
    
    
    
    func editUserProfileData(firstname : String , lastname : String , tagline : String , description : String , profileImage : UIImage? = nil , coverImage : UIImage? = nil){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.addedSuccessful = false
        self.isApiCallDone = false
        
        //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.updateProfile ) else {return}
        
        let user_id = AppData().getUserId()
        
        var formToRequest = MultipartForm()
        
        formToRequest.parts.append(MultipartForm.Part(name: "firstname", value: firstname))
        formToRequest.parts.append(MultipartForm.Part(name: "lastname", value: lastname))
        formToRequest.parts.append(MultipartForm.Part(name: "tagline", value: tagline))
        formToRequest.parts.append(MultipartForm.Part(name: "description", value: description))
        
        if(profileImage != nil){
            

            let imageData  = profileImage!.jpegData(compressionQuality: 1)

            
            formToRequest.parts.append(MultipartForm.Part(name: "profileImage", data: imageData! , filename: "user_image_\(user_id)"))
            
        }
        
        if(coverImage != nil){
            
            let imageData  = coverImage!.jpegData(compressionQuality: 1)
            
            formToRequest.parts.append(MultipartForm.Part(name: "coverImage", data: imageData! , filename: "cover_image_\(user_id)"))
            
        }
        
        
        
        
        let token = AppData().getBearerToken()
        
        //Create request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                print("Got edit profile data response succesfully.....")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(EditProfileResponseModel.self, from: data)
                DispatchQueue.main.async {
                    self.apiResponse = main
                    self.isApiCallSuccessful  = true
                    if(main.message == "Profile Updated Successfully"){
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

