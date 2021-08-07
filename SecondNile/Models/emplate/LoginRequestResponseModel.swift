//
//  LoginRequestResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 01/08/21.
//

import Foundation

//MARK: - Login Request model
class LoginRequestModel : Encodable{
    var email: String?
    var password : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        
    }
}

//MARK: - Socket Request model
class TokenRequestModel : Encodable{
    var token: String?
    var type : String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case type = "type"
        
    }
    init(token: String, type: String) {
        self.token = token
        self.type = type
    }
}

// MARK: - Common ResponseModel
class CommonResponseModel: Codable {
    let message: String
    let data: DataClass
    let status: Int

    init(message: String, data: DataClass, status: Int) {
        self.message = message
        self.data = data
        self.status = status
    }
}

// MARK: - DataClass
class DataClass: Codable {

    init() {
    }
}
