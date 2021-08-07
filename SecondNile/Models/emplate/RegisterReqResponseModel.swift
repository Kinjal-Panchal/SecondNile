//
//  RegisterReqResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 31/07/21.
//

import Foundation


//MARK: - Register Request model
class RegisterRequestModel : Encodable{
    var name : String?
    var nick_name : String?
    var email: String?
    var phone: String?
    var password : String?
    
    
  init(name: String?,nick_name: String?,email: String?,phone: String?,password: String?) {
    
        self.name = name
        self.email = email
        self.nick_name = nick_name
        self.phone = phone
        self.password = password
    }
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nick_name = "nick_name"
        case email = "email"
        case phone = "phone"
        case password = "password"
        
    }
}



// MARK: - RootRegister
class RegisterResponseModel: Codable {
    let message: String
    let data: RegisterData
    let status: Int

    init(message: String, data: RegisterData, status: Int) {
        self.message = message
        self.data = data
        self.status = status
    }
}

// MARK: - DataClass
class RegisterData: Codable {
    let id: Int
    let name, nickName, email, phone: String
    let notificationStatus: Int
    let token: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case nickName = "nick_name"
        case email, phone
        case notificationStatus = "notification_status"
        case token
    }

    init(id: Int, name: String, nickName: String, email: String, phone: String, notificationStatus: Int, token: String) {
        self.id = id
        self.name = name
        self.nickName = nickName
        self.email = email
        self.phone = phone
        self.notificationStatus = notificationStatus
        self.token = token
    }
}



