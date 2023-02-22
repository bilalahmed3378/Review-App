//
//  LoginResponseModel.swift
//  cars conneted
//
//  Created by Bilal Ahmed on 02/08/2022.
//

import Foundation


struct LoginResponseModel : Codable {
    
    
  
    let message : String
    let docs : LoginDocsModel?
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
      
        do{
            message = try container.decode(String?.self, forKey: .message) ?? ""
        } catch{
            message = ""
        }
        
        do{
            docs = try container.decode(LoginDocsModel?.self, forKey: .docs) ?? nil
        } catch{
            docs = nil
        }
        
    }
    
}


struct LoginDocsModel : Codable {
    
    
    let notify: LoginNotifyModel?
    let _id: String
    let email: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
    let coverImage: String
    let description: String
    let firstname: String
    let lastname: String
    let profileImage: String
    let tagline: String
   

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            notify = try container.decode(LoginNotifyModel?.self, forKey: .notify) ?? nil
        } catch{
            notify = nil
        }
       
        do{
            _id = try container.decode(String?.self, forKey: ._id) ?? ""
        } catch{
            _id = ""
        }
        
        
         do{
             email = try container.decode(String?.self, forKey: .email) ?? ""
         } catch{
             email = ""
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
        
        do{
            __v = try container.decode(Int?.self, forKey: .__v) ?? 0
        } catch{
            __v = 0
        }
        
        do{
            coverImage = try container.decode(String?.self, forKey: .coverImage) ?? ""
        } catch{
            coverImage = ""
        }
        
        
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
            profileImage = try container.decode(String?.self, forKey: .profileImage) ?? ""
        } catch{
            profileImage = ""
        }
        
        do{
            tagline = try container.decode(String?.self, forKey: .tagline) ?? ""
        } catch{
            tagline = ""
        }
        
        
    }
    
}


struct LoginNotifyModel : Codable  {
    
    let push: Bool
    let email: Bool
  
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        
        do{
            push = try container.decode(Bool?.self, forKey: .push) ?? false
        } catch{
            push = false
        }
        
        
        do{
            email = try container.decode(Bool?.self, forKey: .email) ?? false
        } catch{
            email = false
        }
        
    }
    
}



