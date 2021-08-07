//
//  File.swift
//  SwiftDEMO_Palak
//
//  Created by MAYUR on 17/01/18.
//  Copyright © 2018 MAYUR. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

//ONLine

var user_defaults = UserDefaults.standard
let appDel = UIApplication.shared.delegate as! AppDelegate

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let KAPPVesion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

let AppName = ""
let currency = "$"

let APPURL = "itms-apps://itunes.apple.com/app/id1540228344"

let GoogleServiceApiKey = "AIzaSyC8mqmVkKtLYxti361nFOT9FErG64BzYI4"

let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
let TEXTFIELD_MaximumLimit = 25
let TEXTFIELD_MinimumLimit = 2


let Appdel = UIApplication.shared.delegate as! AppDelegate
let appName : String = ""


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    //UIScreen.screenWidth
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    //UIScreen.screenHeight

let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6_7 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P_7P = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 736.0
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && SCREEN_MAX_LENGTH == 1024.0
let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 812.0
let IS_IPHONE_XS_MAX = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 896.0
let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .pad && SCREEN_MAX_LENGTH == 1366.0





struct SocialUser {
    var userId: String
    var firstName: String
    var lastName : String
    var userEmail: String
    var socialType: String
    var Profile : String
    
}


//MARK: - Message Alert Show
struct AlertMessage {
    static var messageBar = MessageBarController()
    
    static  func showMessageForError(_ strTitle: String) {
        
        messageBar.MessageShow(title: strTitle as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
    }
    static func showMessageForSuccess(_ strTitle: String) {
        messageBar.MessageShow(title: strTitle as NSString, alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
    }
    static func showSocketErrorMsg(_ strTitle: String){
        messageBar.SocketMessageShow(title: strTitle as NSString, alertType: MessageView.Layout.cardView, alertTheme: .info, TopBottom: true)
    }
    
}
class LoaderClass: NSObject {
    static var act_indicator = ActivityIndicatorViewController()
    // MARK: -- Inicator --
    static func showActivityIndicator() {
        let size = CGSize(width: 30, height: 30)
        
        act_indicator.startAnimating(size, message: "", type: NVActivityIndicatorType(rawValue:2)!)
    }
    static func hideActivityIndicator() {
        act_indicator.stopAnimating()
    }
}

