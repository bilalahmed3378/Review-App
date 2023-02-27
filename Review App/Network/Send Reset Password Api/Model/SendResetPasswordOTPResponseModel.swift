//
//  SendResetPasswordOTPResponseModel.swift
//  Review App
//
//  Created by Bilal Ahmed on 27/02/2023.
//

import Foundation


struct SendResetPasswordOTPResponseModel : Codable {
    
    
    
       let message : String
       
       init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
          
           
           do{
               message = try container.decode(String?.self, forKey: .message) ?? ""
           } catch{
               message = ""
           }
           
          
       }
}
