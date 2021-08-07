//
//  ProfileResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 02/08/21.
//

import Foundation

//MARK: - Profile Request model
class ProfileUpdateRequestModel : Encodable{
    var name : String?
    var nick_name : String?
    var email: String?
    var phone: String?
   
  init(name: String?,nick_name: String?,email: String?,phone: String?) {
    
        self.name = name
        self.email = email
        self.nick_name = nick_name
        self.phone = phone
        
    }
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nick_name = "nick_name"
        case email = "email"
        case phone = "phone"
        
        
    }
}

// MARK: - ProfileResponseModel
class ProfileResponseModel: Codable {
    let message: String?
    let data: ProfileDetails?
    let status: Int?

    init(message: String, data: ProfileDetails, status: Int) {
        self.message = message
        self.data = data
        self.status = status
    }
}

// MARK: - DataClass
class ProfileDetails: Codable {
    let id: Int?
    let name, nickName, email, phone: String?
    let notificationStatus: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nickName = "nick_name"
        case email, phone
        case notificationStatus = "notification_status"
    }

    init(id: Int, name: String, nickName: String, email: String, phone: String, notificationStatus: Int) {
        self.id = id
        self.name = name
        self.nickName = nickName
        self.email = email
        self.phone = phone
        self.notificationStatus = notificationStatus
    }
}




