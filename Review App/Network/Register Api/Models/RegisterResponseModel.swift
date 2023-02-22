//
//  RegisterResponseModel.swift
//  MeccaFitness
//
//  Created by CodeCue on 09/04/2022.
//

import Foundation

struct RegisterResponseModel : Codable {
    
    
  
    let message : String
    
    
    
    init(from decoder: Decoder) throws {
       
               
       let container = try decoder.container(keyedBy: CodingKeys.self)

       
       
       do {
           message = try container.decode(String?.self, forKey: .message) ?? ""
       } catch  {
           message = ""
       }
       
      
       
   }
    
    
}
