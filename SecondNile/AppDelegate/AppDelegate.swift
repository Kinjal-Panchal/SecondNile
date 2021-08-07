//
//  AppDelegate.swift
//  Seconf Nile
//
//  Created by panchal kinjal on 15/07/21.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseMessaging
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var currentViewController : UIViewController? = nil
   
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        HideBackButtonTitle()
        for family: String in UIFont.familyNames
               {
                   print(family)
                   for names: String in UIFont.fontNames(forFamilyName: family)
                   {
                       print("== \(names)")
                   }
               }
        
        // setupUserLogin()

        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }

        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        setupPushNotification(application: application)

        return true

    }


    
}

extension AppDelegate {
    
    func HideBackButtonTitle(){

        let naviagtionController = UINavigationController()
        naviagtionController.interactivePopGestureRecognizer?.isEnabled = true

        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)

    }

    
    func GoToHome() {

        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let tabVc = storyborad.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        print(tabVc.children)
        if (UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil) == true {
            if let homevc = tabVc.children[0].children[0] as? HomeVC {
                var token  = String()
                if user_defaults.getUserData() != nil{
                    let userdata = user_defaults.getUserData()
                    Singletone.shared.userProfileData = userdata
                    Singletone.shared.BearerDeviceToken = userdata?.token ?? ""
                }
                if(UserDefaults.standard.object(forKey:AllKeys.KToken) != nil) {
                     token =  UserDefaults.standard.object(forKey: AllKeys.KToken) as! String
                   } else {
                       token = "Token"
                   }
                print(token)
                
                homevc.homeUserModel.tokenRequestModel = TokenRequestModel(token:token, type: "ios")
                homevc.homeUserModel.webserviceGetToken()
            //            NotificaionStatusCheck.shared.currentViewController(homevc)
            //
                    }
        }
        self.window?.rootViewController = tabVc
    }


    func GoToLogin(isFromDonate : Bool , _ donationReqModel : DonationRequestModel = DonationRequestModel(),isfromLogout:Bool) {

        let Login : LoginVC = LoginVC.instantiate(appStoryboard: .Auth)
        Login.isFromDonate = isFromDonate
        Login.isFromLogout = isfromLogout
        Login.donationReqModel = donationReqModel
        let navLoginVC = UINavigationController(rootViewController: Login)
        navLoginVC.navigationBar.isHidden = true
        self.window?.rootViewController = navLoginVC

    }

    func SetLogout() {
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
            
            if key == AllKeys.KToken || key  == "i18n_language" {
                
            }
            else {
                
                UserDefaults.standard.removeObject(forKey: key)
                
            }
        }
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.isUserLogin.rawValue)
        UserDefaults.standard.synchronize()
        GoToLogin(isFromDonate: false, isfromLogout: true)
    }
    
    func setupUserLogin(){
        
        if UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil,UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as! Bool
        {
            if user_defaults.getUserData() != nil{
                let userdata = user_defaults.getUserData()
                Singletone.shared.userProfileData = userdata
                Singletone.shared.BearerDeviceToken = userdata?.token ?? ""
                GoToHome()
            }
            self.noInternetConnectionRetry()
        }else{
            setupUserLogin()
            self.noInternetConnectionRetry()
        }
        
    }
    
    func noInternetConnectionRetry(){
        if Reachability.isConnectedToNetwork(){
            //self.webserviceOfInitAPI()
        }else{
            UIApplication.topViewController()?.showAlertWithTwoButtonCompletion(title: "Connectivity", Message: UrlConstant.NoInternetConnection, defaultButtonTitle: "Retry", completionHandler: { (index) in
                if index == .confirm{
                    if !Reachability.isConnectedToNetwork(){
                        self.noInternetConnectionRetry()
                    }else{
                       // self.webserviceOfInitAPI()
                    }
                }
            })
        }
    }
}
