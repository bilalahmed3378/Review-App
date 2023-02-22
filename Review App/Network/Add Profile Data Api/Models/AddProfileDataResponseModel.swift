//
//  AddProfileDataResponseModel.swift
//  MeccaFitness
//
//  Created by CodeCue on 11/04/2022.
//

import Foundation


struct AddProfileResponseModel : Codable {
    
    
    
       let message : String
       let docs: AddProfileDataModel?
       
       init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
          
           
           do{
               message = try container.decode(String?.self, forKey: .message) ?? ""
           } catch{
               message = ""
           }
           
           do{
               docs = try container.decode(AddProfileDataModel?.self, forKey: .docs) ?? nil
           } catch{
               docs = nil
           }
           
           
           
       }
}

struct AddProfileDataModel : Codable  {
    
    let _id: String
    let createdAt: String
    let updatedAt: String
//    let __v: Int
    let description: String
    let firstname: String
    let lastname: String
    let tagline: String
    let coverImage: String
    let profileImage: String

   
 
   
  
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
       
        do{
            _id = try container.decode(String?.self, forKey: ._id) ?? ""
        } catch{
            _id = ""
        }
        
      
        do{
            coverImage = try container.decode(String?.self, forKey: .coverImage) ?? ""
        } catch{
            coverImage = ""
        }
        
        do{
            profileImage = try container.decode(String?.self, forKey: .profileImage) ?? ""
        } catch{
            profileImage = ""
        }
        
         do{
             createdAt = try container.decode(String?.self, forKey: .createdAt) ?? ""
         } catch{
             createdAt = ""
         }
        
        do{
            updatedAt = try container.decode(String?.self, forKey: .updatedAt) ?? ""
        } catch{
            updatedAt = ""
        }
        
//        do{
//            __v = try container.decode(Int?.self, forKey: .__v) ?? 0
//        } catch{
//            __v = 0
//        }
        
      
        do{
            description = try container.decode(String?.self, forKey: .description) ?? ""
        } catch{
            description = ""
        }
        
        
        do{
            firstname = try container.decode(String?.self, forKey: .firstname) ?? ""
        } catch{
            firstname = ""
        }
        
        do{
            lastname = try container.decode(String?.self, forKey: .lastname) ?? ""
        } catch{
            lastname = ""
        }
        
       
        do{
            tagline = try container.decode(String?.self, forKey: .tagline) ?? ""
        } catch{
            tagline = ""
        }
        
        
       
    }
}



