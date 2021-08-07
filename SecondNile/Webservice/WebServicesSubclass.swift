//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by panchal kinjal on 04/06/21.
//

import Foundation
class WebServiceSubClass{


    class func Registration(reqModel : RegisterRequestModel , completion: @escaping (Bool,RegisterResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: RegisterResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    class func Login(reqModel : LoginRequestModel , completion: @escaping (Bool,RegisterResponseModel? , Any)->()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: RegisterResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func Token(reqModel : TokenRequestModel , completion: @escaping (Bool,CommonResponseModel? , Any)->()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.deviceToken.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func ChangePassword(reqModel : ChangePassRequestModel , completion: @escaping (Bool,CommonResponseModel? , Any)->()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changePassword.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func ForgotPassword(reqModel : ForgotPassRequestModel , completion: @escaping (Bool,CommonResponseModel? , Any)->()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.forgotPassword.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func Logout(reqModel : commonRequestModel, completion: @escaping (Bool,CommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.logout.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func Home(keyPath : String , completion: @escaping (Bool,HomeResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel:HomeResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func Profile(keyPath : String , completion: @escaping (Bool,ProfileResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel:ProfileResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func updateProfile(reqModel : ProfileUpdateRequestModel , completion: @escaping (Bool,ProfileResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateProfile.rawValue, requestModel: reqModel, responseModel: ProfileResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func NotificationStatusChange(reqModel : NotificationRequestModel , completion: @escaping (Bool,CommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.Notification.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }


    class func DonationPage(keyPath : String , completion: @escaping (Bool,DonateResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel:DonateResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func CampaignList(keyPath : String , completion: @escaping (Bool,CampaignResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel:CampaignResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func donation(reqModel : DonationRequestModel , completion: @escaping (Bool,CommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.Donation.rawValue, requestModel: reqModel, responseModel: CommonResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    
    
    
}
