//
//  GetReplyOnRatingResponseModel.swift
//  Review App
//
//  Created by Bilal Ahmed on 01/03/2023.
//

import Foundation


struct GetReplyOnRatingResponseModel : Codable {
    
    
    
       let message : String
       let docs: GetReplyOnRatingDocsModel?
       
       init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
          
           
           do{
               message = try container.decode(String?.self, forKey: .message) ?? ""
           } catch{
               message = ""
           }
           
           do{
               docs = try container.decode(GetReplyOnRatingDocsModel?.self, forKey: .docs) ?? nil
           } catch{
               docs = nil
           }
           
           
           
       }
}

struct GetReplyOnRatingDocsModel : Codable  {
    
    let _id: String
    let reviewerId: GetReplyOnRatingReviewerFromModel?
    let reviewFor: GetReplyOnRatingReviewForModel?
    let ratings: Int
    let message: String
    let replyHistory: [GetReplyOnRatingReplyHistoryModel]
    let createdAt: String
    let updatedAt: String


    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
       
        do{
            _id = try container.decode(String?.self, forKey: ._id) ?? ""
        } catch{
            _id = ""
        }
        
      
        do{
            reviewerId = try container.decode(GetReplyOnRatingReviewerFromModel?.self, forKey: .reviewerId) ?? nil
        } catch{
            reviewerId = nil
        }
        
        do{
            reviewFor = try container.decode(GetReplyOnRatingReviewForModel?.self, forKey: .reviewFor) ?? nil
        } catch{
            reviewFor = nil
        }
        
         do{
             ratings = try container.decode(Int?.self, forKey: .ratings) ?? 0
         } catch{
             ratings = 0
         }
        
        do{
            message = try container.decode(String?.self, forKey: .message) ?? ""
        } catch{
            message = ""
        }
        
        
        do{
            replyHistory = try container.decode([GetReplyOnRatingReplyHistoryModel]?.self, forKey: .replyHistory) ?? []
        } catch{
            replyHistory = []
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
        
    }
}

struct GetReplyOnRatingReviewerFromModel : Codable  {
    
    let _id: String
    let createdAt: String
    let updatedAt: String
    let email: String
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
        
        do{
            email = try container.decode(String?.self, forKey: .email) ?? ""
        } catch{
            email = ""
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
            tagline = try container.decode(String?.self, forKey: .tagline) ?? ""
        } catch{
            tagline = ""
        }
        
        
       
    }
}


struct GetReplyOnRatingReviewForModel : Codable  {
    
    let _id: String
    let createdAt: String
    let updatedAt: String
    let email: String
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
        
        do{
            email = try container.decode(String?.self, forKey: .email) ?? ""
        } catch{
            email = ""
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
            tagline = try container.decode(String?.self, forKey: .tagline) ?? ""
        } catch{
            tagline = ""
        }
        
        
       
    }
}


struct GetReplyOnRatingReplyHistoryModel : Codable  {
    
    
    
    
    
}

