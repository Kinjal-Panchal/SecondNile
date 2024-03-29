//
//  URLSessionRequestManager.swift
//  Danfo_Rider
//
//  Created by panchal kinjal on 04/06/21.
//


import UIKit
import Foundation
import SystemConfiguration

typealias CompletionResponse<R:Codable> = (Bool,Codable?,Any) -> ()
class URLSessionRequestManager {
    
    static func BEARER_HEADER() -> [String:String]{
        return  APIEnvironment.headers
    }
    
    class func makeGetRequest<C:Codable>(urlString: String, responseModel: C.Type, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            
            completion(false, nil, NoInternetResponseDic)
            //AlertMessage.showMessageForError(UrlConstant.NoInternetConnection)
            return
        }
        
       let strURL = urlString.hasPrefix(ApiKey.GoogleServiceDrawPath.rawValue) ? urlString : APIEnvironment.baseURL + urlString
      
        guard let url = URL(string: strURL) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = GetRequestType.GET.rawValue
      
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        print("the url is \(url) and the headers are \(BEARER_HEADER())")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            DispatchQueue.main.async {
                completion(status,obj,dic)
            }
           
        }
    }
    
    class func makePostRequest<C:Codable, P:Encodable>(urlString: String, requestModel: P, responseModel: C.Type, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, NoInternetResponseDic)
           // AlertMessage.showMessageForError(UrlConstant.NoInternetConnection)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, ErrorResponseDic)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
            
            print("the url is \(url) and the parameters are \n \(bodyDic) and the headers are \(BEARER_HEADER())")
        }
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    class func makeImageUploadRequest<C:Codable, P:Codable>(urlString: String, requestModel: P, responseModel: C.Type, image: UIImage, imageKey: String, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, NoInternetResponseDic)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        guard let mediaImage = UploadMediaModel(mediaType: .Image, forKey: imageKey, withImage: image) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
        
    }
    
    class func makeMultipleImageRequest<C:Codable, P:Encodable>(urlString: String, requestModel: P, responseModel: C.Type, imageKey: String ,arrImageData : [UIImage]?, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, NoInternetResponseDic)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        var mediaArr = [UploadMediaModel]()
        if let dataDic = arrImageData{
            for each in dataDic{
                guard let mediaImage = UploadMediaModel(mediaType: .Image, forKey: imageKey, withImage: each) else {
                    completion(false, nil, ErrorResponseDic)
                    return
                }
                mediaArr.append(mediaImage)
            }
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: mediaArr, boundary: boundary)
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    class func makeMediaUploadRequest<C:Codable, P:Codable>(urlString: String, requestModel: P, responseModel: C.Type, mediaType: MediaType,file_url: String, fileKey: String, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, NoInternetResponseDic)
           // AlertMessage.showMessageForError(UrlConstant.NoInternetConnection)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        guard let mediaUrl = URL(string: file_url) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        guard let mediaImage = UploadMediaModel(mediaType: mediaType, forKey: fileKey, fileUrl: mediaUrl) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: [mediaImage], boundary: boundary)
        print("BODY DIC: \(paramaterDic)")
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        print("REQUEST: \(request)")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    class func makeMultipleMediaUploadRequest<C:Codable, P:Codable>(urlString: String, requestModel: P, responseModel: C.Type, mediaArr: [UploadMediaModel], completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, NoInternetResponseDic)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, ErrorResponseDic)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: mediaArr, boundary: boundary)
        
        print("BODY DIC: \(paramaterDic)")
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        print("REQUEST: \(request)")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
}


