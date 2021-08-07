//
//  NotificationReqResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 02/08/21.
//

import Foundation
//MARK: - Notification Request model
class NotificationRequestModel : Encodable{
    
    var status: String?
    
    init(status: String?) {
      
          self.status = status
      }
   
    enum CodingKeys: String, CodingKey {
        case status = "status"
        
    }
}
