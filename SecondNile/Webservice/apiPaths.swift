//
//  apiPaths.swift

import Foundation

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment : String {
 
///Development URL : Picka ride customer
    case Development = "http://www.secondnile.com/api/v1/user/"
    case Live = "not provided"
     
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .Development
    }
    
    static var headers : [String:String]
    {
        if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
                
                if user_defaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as! Bool
                        {
                            return ["Accept":"application/json",
                                    "Authorization" : "Bearer \(Singletone.shared.BearerDeviceToken)"
                            
                            ]
                            
                        }else{
                            return ["Accept":"application/json"]
                        }
                    }
                }
            }
        }
        return ["Accept":"application/json"]
    }
}

enum ApiKey: String {

    case login                                = "login"
    case register                             = "register"//Done
    case logout                               = "logout"//Done
    case changePassword                       = "change-password"
    case forgotPassword                       = "forgot-password"
    case deviceToken                          = "device-token"
    case Home                                 = "homescreen"
    case GoogleServiceDrawPath                = "https://maps.googleapis.com/maps/api/directions/json?"
    case profile                              = "profile"
    case updateProfile                        = "profile/update"
    case Notification                         = "notification"
    case DonatePage                           = "donate-page"
    case campaignList                         = "campaigns"
    case Donation                             = "donation"
   
}

 


