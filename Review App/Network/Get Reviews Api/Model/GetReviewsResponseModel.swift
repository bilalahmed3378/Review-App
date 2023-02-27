//
//  GetReviewsResponseModel.swift
//  Review App
//
//  Created by Bilal Ahmed on 23/02/2023.
//

import Foundation


struct GetReviewsResponseModel : Codable {
    
    
    
       let message : String
       let docs: [GetReviewsdocsModel]?
       
       init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
          
           
           do{
               message = try container.decode(String?.self, forKey: .message) ?? ""
           } catch{
               message = ""
           }
           
           do{
               docs = try container.decode([GetReviewsdocsModel]?.self, forKey: .docs) ?? []
           } catch{
               docs = []
           }
           
           
           
       }
}


struct GetReviewsdocsModel : Codable  {
    
    let _id: String
    let reviewerId: GetReviewsReviewerFromModel?
    let reviewFor: GetReviewsReviewerForModel?
    let ratings: Int
    let message: String
    let replyHistory: [GetReviewsReplyHistoryModel]
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
            reviewerId = try container.decode(GetReviewsReviewerFromModel?.self, forKey: .reviewerId) ?? nil
        } catch{
            reviewerId = nil
        }
        
        do{
            reviewFor = try container.decode(GetReviewsReviewerForModel?.self, forKey: .reviewFor) ?? nil
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
            replyHistory = try container.decode([GetReviewsReplyHistoryModel]?.self, forKey: .replyHistory) ?? []
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

struct GetReviewsReviewerFromModel : Codable  {
    
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


struct GetReviewsReviewerForModel : Codable  {
    
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


struct GetReviewsReplyHistoryModel : Codable  {
    
    
    
    
    
}
