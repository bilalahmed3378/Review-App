//
//  VerifyOTPEmailApi.swift
//  Review App
//
//  Created by Bilal Ahmed on 06/03/2023.
//

import Foundation

struct VerifyOTPEmailResponseModel : Codable {
    
    
    
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
