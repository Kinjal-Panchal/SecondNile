//
//  ChangePasswordReqResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 01/08/21.
//

import Foundation

//MARK: - Change Password Request model
class ChangePassRequestModel : Encodable{
    
    var new_password: String?
    var new_confirm_password : String?
    var old_password : String?
   
    enum CodingKeys: String, CodingKey {
        case new_password = "new_password"
        case new_confirm_password = "new_confirm_password"
        case old_password = "old_password"
        
    }
}

//MARK:- ==== Forgot password Request model =====
class ForgotPassRequestModel : Encodable{
    
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

class commonRequestModel : Encodable{
    
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
