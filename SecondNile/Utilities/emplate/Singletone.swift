//
//  Singletone.swift
//  SecondNile
//
//  Created by panchal kinjal  on 31/07/21.
//

import Foundation

class Singletone : NSObject {
    
    static let shared = Singletone()
    
    var userProfileData : RegisterData?
    var UserId : String = ""
    var Api_Key = String()
    var BearerDeviceToken : String = ""
    
}
