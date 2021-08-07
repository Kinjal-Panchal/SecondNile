//
//  Appdelegate+PushNotification.swift
//  SecondNile
//
//  Created by panchal kinjal  on 31/07/21.
//

import Foundation
import UIKit
import FirebaseMessaging
import Firebase

//MARK:- ======= Register token ========
extension AppDelegate : UNUserNotificationCenterDelegate , MessagingDelegate {
        
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    
        Messaging.messaging().apnsToken = deviceToken
        
        if let token = Messaging.messaging().fcmToken{
            print(token)
            
            UserDefaults.standard.setValue(token, forKey: AllKeys.KToken)
            
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("i am not available in simulator :( \(error)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("Firebase registration token: \(String(describing: fcmToken))")
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        let savedFCMToken = UserDefaults.standard.object(forKey: AllKeys.KToken) as? String
        if savedFCMToken != fcmToken {
            UserDefaults.standard.set(fcmToken, forKey: AllKeys.KToken)
            UserDefaults.standard.synchronize()
            // Update FCMToken to server by doing API call...
        }
    }
    
    
  func setupPushNotification(application : UIApplication)
    {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (status, error) in
                
          }
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
         application.registerForRemoteNotifications()
        
      }
}

class NotificaionStatusCheck {
    
    
    var window: UIWindow?
    
    private var currentViewController : UIViewController? = nil
    
    
     static let shared = NotificaionStatusCheck()
    
    public func currentViewController(_ vc: UIViewController?) {
        self.currentViewController = vc
        checkNotificationsAuthorizationStatus()
    }
    
    
    private func checkNotificationsAuthorizationStatus() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .authorized:
                print("The app is authorized to schedule or receive notifications.")
                
            case .denied:
                print("The app isn't authorized to schedule or receive notifications.")
                self.NotificationPopup()
            case .notDetermined:
                print("The user hasn't yet made a choice about whether the app is allowed to schedule notifications.")
                self.NotificationPopup()
            case .provisional:
                print("The application is provisionally authorized to post noninterruptive user notifications.")
                self.NotificationPopup()
            case .ephemeral:
                print("The application is provisionally authorized to post noninterruptive user notifications.")
            @unknown default:
                break
            }
        }
        
    }

    private func NotificationPopup(){
            let alertController = UIAlertController(title: "Notification Alert", message: "Please Turn on the Notification to get update every time the Show Starts", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            DispatchQueue.main.async {
                self.currentViewController?.present(alertController, animated: true, completion: nil)
                
            }
            
        }
    
    
    
    
}
