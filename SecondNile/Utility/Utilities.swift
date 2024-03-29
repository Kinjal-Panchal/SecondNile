//
//  Utilities.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 15/03/21.
//

import Foundation
import UIKit
import GoogleMaps

//==========================
//MARK: === Color ===
//==========================
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class Utility {
    class func showAlert(_ title: String = "", message: String, vc: UIViewController, completionHandler: (() -> Void)? = nil ) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: {  (action) in
            print("ok button tapped")
            completionHandler?()
        })
        alert.addAction(cancelAction)
        
        //            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        //            alertWindow.rootViewController = UIViewController()
        //            alertWindow.windowLevel = UIWindow.Level.alert + 1;
        //            alertWindow.makeKeyAndVisible()
        vc.present(alert, animated: true, completion: nil)
    }
    class func ShowAlert(OfMessage : String){
        let alert = UIAlertController(title: "", message: OfMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.shared.delegate?.window??.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    
    class func showAlert(_ title: String, message: String, vc: UIViewController) -> Void
    {
        let alert = UIAlertController(title:title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        if(vc.presentedViewController != nil)
        {
            vc.dismiss(animated: true, completion: nil)
        }
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
        
    }
    
    /// Response may be Any Type
    class func showAlertOfAPIResponse(param: Any, vc: UIViewController? = UIApplication.topViewController()) {
        
        if let res = param as? String {
//            Utility.showAlert("", message: res, vc: vc)
            Toast.show(message: res, state: .failure)
        }
        else if let resDict = param as? NSDictionary {
            if let msg = resDict.object(forKey: "message") as? String {
//                Utility.showAlert("", message: msg, vc: vc)
                Toast.show(message: msg, state: .failure)
            }
            else if let msg = resDict.object(forKey: "msg") as? String {
//                Utility.showAlert("", message: msg, vc: vc)
                Toast.show(message: msg, state: .failure)
            }
            else if let msg = resDict.object(forKey: "message") as? [String] {
//                Utility.showAlert("", message: msg.first ?? "", vc: vc)
                Toast.show(message: msg.first ?? "Something Went wrong", state: .failure)
            }
        }
        else if let resAry = param as? NSArray {
            
            if let dictIndxZero = resAry.firstObject as? NSDictionary {
                if let message = dictIndxZero.object(forKey: "message") as? String {
//                    Utility.showAlert("", message: message, vc: vc)
                    Toast.show(message:message, state: .failure)
                }
                else if let msg = dictIndxZero.object(forKey: "msg") as? String {
//                    Utility.showAlert("", message: msg, vc: vc)
                    Toast.show(message:msg, state: .failure)
                }
                else if let msg = dictIndxZero.object(forKey: "message") as? [String] {
//                    Utility.showAlert("", message: msg.first ?? "", vc: vc)
                    Toast.show(message:msg.first ?? "Something went wrong", state: .failure)
                }
            }
            else if let msg = resAry as? [String] {
//                Utility.showAlert("", message: msg.first ?? "", vc: vc)
                Toast.show(message:msg.first ?? "Something went wrong", state: .failure)
            }
        }
    }
    
    //MARK: ====Location Permission
    class func showTurnOnLocationAlert() {
        let alert = UIAlertController(title: "", message: "Location service is disabled. To re-enable, please go to Settings and turn on Location Service for this application.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Settings", style: .default, handler: { action in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        let OKAction = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        
        alert.addAction(OKAction)
        
        alert.addAction(defaultAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
    
    class func generateHaptic(type : HapticTypes){
        switch type {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .sucess:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    //MARK: ====Activity indicator
    class func showHUD() {
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
      guard let window = UIApplication.shared.keyWindow else { return}
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = window.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = UIColor.appColor(ThemeColor.themeGold).withAlphaComponent(0.8)
        activityIndicator.tag = viewComponentsTags.ActivityIndicator.rawValue
        window.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    class func hideHUD() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else { return}
            let activityIndicator = window.viewWithTag(viewComponentsTags.ActivityIndicator.rawValue) as? UIActivityIndicatorView
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    
    }
    
    class func applyTheme(on mapview: GMSMapView  , mapStyle : MapStyle){
        do {
            let strJson = mapStyle == .dark ? "darkStyle" : "lightMapTheme"
            if let styleURL = Bundle.main.url(forResource: strJson, withExtension: "json") {
                mapview.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
      
    }
    
    class func ShowMarker(on mapview: GMSMapView,coordinate : CLLocationCoordinate2D ){
        let marker = GMSMarker()
        let markerImage = UIImage(named: "imgCurrentLocPin") ?? UIImage()
        marker.icon = imageWithImage(image: markerImage, scaledToSize: CGSize(width: 35.0, height: 35.0))
        marker.position = coordinate
//                marker.title = "You are here"
//                marker.snippet = Singleton.shared.CurrentAddressString
        marker.map = mapview
    }
    
    class func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

