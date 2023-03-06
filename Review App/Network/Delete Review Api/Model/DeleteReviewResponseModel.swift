//
//  DeleteReviewResponseModel.swift
//  Review App
//
//  Created by Bilal Ahmed on 03/03/2023.
//

import Foundation


struct DeleteReviewResponseModel : Codable {
    
    
    
       let message : String
       let review: DeleteReviewDocsModel?
       
       init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
          
           
           do{
               message = try container.decode(String?.self, forKey: .message) ?? ""
           } catch{
               message = ""
           }
           
           do{
               review = try container.decode(DeleteReviewDocsModel?.self, forKey: .review) ?? nil
           } catch{
               review = nil
           }
           
           
           
       }
}

struct DeleteReviewDocsModel : Codable  {
    
    let _id: String
    let reviewerId: String
    let reviewFor: String
    let ratings: Int
    let message: String
    let replyHistory: [String]
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
            reviewerId = try container.decode(String?.self, forKey: .reviewerId) ?? ""
        } catch{
            reviewerId = ""
        }
        
        do{
            reviewFor = try container.decode(String?.self, forKey: .reviewFor) ?? ""
        } catch{
            reviewFor = ""
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
            replyHistory = try container.decode([String]?.self, forKey: .replyHistory) ?? []
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
