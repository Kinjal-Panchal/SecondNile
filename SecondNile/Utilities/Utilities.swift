//
//  UtilityClass.swift
//  FairWay
//
//  Created by Mayur iMac on 19/08/19.
//  Copyright © 2019 EWW077. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher



class UtilityClass: NSObject {

       static let date = Date()
       static let formatter = DateFormatter()


    class func alertView(withTitle title: String?, message: String?, buttons buttonArray: [Any]?, completion block: @escaping (_ buttonIndex: Int) -> Void) {

        let strTitle = title

        let alertController = UIAlertController(title: strTitle, message: message, preferredStyle: .alert)
        for buttonTitle in buttonArray ?? [] {
            guard let buttonTitle = buttonTitle as? String else {
                continue
            }
            var action: UIAlertAction?
            if (buttonTitle.lowercased() == "cancel") {
                action = UIAlertAction(title: buttonTitle, style: .destructive, handler: { action in
                    let index = (buttonArray as NSArray?)?.index(of: action.title ?? "")
                    block(index!)
                })
            } else {
                action = UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                    let index = (buttonArray as NSArray?)?.index(of: action.title ?? "")
                    block(index!)
                })
            }

            if let action = action {
                alertController.addAction(action)
            }
        }
        self.topMostController()?.present(alertController, animated: true)

    }
    //MARK:- Date string format change ========
    class func getDateTimeString(dateString:String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"                 // Note: S is fractional second
        let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMM d, yyyy" //- h:mm a"//"MMM d, yyyy h:mm a"
        //dateFormatter2.timeStyle = .medium

        let stringFromDate = dateFormatter2.string(from: dateFromString!) // "Nov 25, 2015" as String
        return stringFromDate
    }

    //MARK:- Date string format change ========
    class func DateStringChange(Format:String,getFormat:String,dateString:String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Format                // Note: S is fractional second
        let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat =  getFormat//"MMM d, yyyy h:mm a"
        dateFormatter2.locale = Locale.init(identifier: "en_US")
        let stringFromDate = dateFormatter2.string(from: dateFromString!) // "Nov 25, 2015" as String
        return stringFromDate
    }



    class func setimageFromcharacter(FirstName:String,lastName:String,imageselect : UIImageView){
        let lblNameInitialize = UILabel()
        lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
        lblNameInitialize.textColor = UIColor.white
        lblNameInitialize.text =  String(FirstName.first!)  +   String(lastName.first!)
        lblNameInitialize.textAlignment = NSTextAlignment.center
        lblNameInitialize.backgroundColor = colors.ThemeDarkBlue.value

        lblNameInitialize.layer.cornerRadius = 50.0

        UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
        lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        imageselect.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

    }


    class func CheckLocation(currentVC:UIViewController){

            let alertController = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success)
                        in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            alertController.addAction(settingsAction)

            alertController.addAction(OKAction)
            OperationQueue.main.addOperation {
                currentVC.present(alertController, animated: true,
                             completion:nil)
            }

    }

    class func CheckContact(currentVC:UIViewController){

        let alertController = UIAlertController(title: appName, message: "Please allow the app to access your contacts through the Settings.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success)
                    in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)

        alertController.addAction(OKAction)
        OperationQueue.main.addOperation {
            currentVC.present(alertController, animated: true,
                              completion:nil)
        }

    }

    class func getCurrentDate() -> String{
           formatter.dateFormat = "dd.MM.yyyy"
           let result = formatter.string(from: date)
           return result
       }

    class func showDataNotFound(text:String,View:UIView,isHidden:Bool) {
        let label = UILabel(frame: CGRect(x:UIScreen.main.bounds.width/2 - 120,y:UIScreen.main.bounds.height/2 - 25,width:240,height: 50))
        label.textAlignment = .center
        label.textColor = .black
        // label.backgroundColor = .yellow
        label.font = CustomFont.MuseoSans_300.returnFont(FontSize.size20.rawValue)
        label.text =  text
        View.addSubview(label)
        View.isHidden = isHidden
        label.isHidden = isHidden
    }

    class func showNoDataFound(text:String,View:UIView) {
        let label = UILabel(frame: CGRect(x:UIScreen.main.bounds.width/2 - 120,y:UIScreen.main.bounds.height/2 - 25,width:240,height: 50))
        label.textAlignment = .center
        label.textColor = .black
       // label.backgroundColor = .yellow
        label.font = CustomFont.MuseoSans_300.returnFont(FontSize.size14.rawValue)
        label.text =  text
        View.addSubview(label)
    }


    class func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController

        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }

        return topController
    }

    class func isValidEmail(testStr:String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: testStr)
        }



    class func showAlert(_ title: String, message: String, vc: UIViewController) -> Void
    {
        let alert = UIAlertController(title: title,
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
       // Appdel.window?.rootViewController?.present(alert, animated: true, completion: nil)
        vc.present(alert, animated: true, completion: nil)
    }


    // Error Message Show
    class func defaultMsg(result:Any) -> String {
        if let res = result as? String {
            return res
        }
        else if let resDict = result as? [String:Any] {
            if let message = resDict["message"] as? String {
                return message
            }
            else if let msg = resDict["message"] as? [String]{
                return msg.joined(separator: "\n")
            }
        }
        else if let resAry = result as? [[String:Any]] {
            if let message = resAry[0]["message"] as? String{
                return message
            }
        }

        return ""
    }

   class func convertToBase64(image: UIImage) -> String {
    return image.pngData()!
            .base64EncodedString()
    }

    public enum ImageFormat {
        case png
        case jpeg(CGFloat)
    }

    class func convertImageTobase64(format: ImageFormat, image:UIImage) -> String? {
           var imageData: Data?
           switch format {
           case .png: imageData = image.pngData()
           case .jpeg(let compression): imageData = image.jpegData(compressionQuality: compression)
               //UIImageJPEGRepresentation(image, compression)
           }
           return imageData?.base64EncodedString()
       }

      class func base64Convert(base64String: String?) -> UIImage{
           if (base64String?.isEmpty)! {
               return #imageLiteral(resourceName: "no_image_found")
           }else {
               // !!! Separation part is optional, depends on your Base64String !!!
               let temp = base64String?.components(separatedBy: ",")
               let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
               let decodedimage = UIImage(data: dataDecoded)
               return decodedimage!
           }
       }


    class func attributBtnSetup(btn:UIButton , FullString : String , attributeText:String){
           let main_string = FullString
           let string_to_color = attributeText

           let range = (main_string as NSString).range(of: string_to_color)

           let attribute = NSMutableAttributedString.init(string: main_string)
          attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.ThemeLightBlue.value , range: range)
         attribute.addAttribute(NSAttributedString.Key.font, value: CustomFont.MuseoSans_700.returnFont(21.0) , range: range)
            btn.setAttributedTitle(attribute, for: .normal)
       }

    class func selecteUI(view:UIView,Selected : Bool , textfield : UITextField){
        view.backgroundColor =   colors.ThemeTextViewBG.value
        view.layer.cornerRadius =  view.frame.height / 2
        view.clipsToBounds = true
        view.layer.borderColor =  Selected == true ? colors.ThemeDarkBlue.value.cgColor : UIColor.hexStringToUIColor(hex: "#E5E5E5").cgColor
        textfield.textColor = Selected == true ? colors.ThemeDarkBlue.value : colors.black.value
        view.layer.borderWidth = 1.0
    }

    class func FillDataUI(view:UIView,Selected : Bool,textfield : UITextField){
        view.backgroundColor =   colors.ThemeBGColour.value
        view.layer.cornerRadius =  view.frame.height / 2
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#E5E5E5").cgColor
        view.layer.borderWidth = 1.0
        textfield.textColor = colors.black.value
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
        activityIndicator.color = colors.ThemeLightBlue.value
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
    
    class func showAlertOfAPIResponse(param: Any, vc: UIViewController? = UIApplication.topViewController()) {
        
        if let res = param as? String {
//            Utility.showAlert("", message: res, vc: vc)
            UtilityClass.showAlert(AppName, message: res, vc: vc ?? UIViewController())
        }
        else if let resDict = param as? NSDictionary {
            if let msg = resDict.object(forKey: "message") as? String {
//                Utility.showAlert("", message: msg, vc: vc)
                UtilityClass.showAlert(AppName, message: msg, vc: vc ?? UIViewController())
            }
            else if let msg = resDict.object(forKey: "msg") as? String {
//                Utility.showAlert("", message: msg, vc: vc)
                UtilityClass.showAlert(AppName, message: msg, vc: vc ?? UIViewController())
            }
            else if let msg = resDict.object(forKey: "message") as? [String] {
//                Utility.showAlert("", message: msg.first ?? "", vc: vc)
                UtilityClass.showAlert(AppName, message: msg.first ?? "", vc: vc ?? UIViewController())
            }
        }
        else if let resAry = param as? NSArray {
            
            if let dictIndxZero = resAry.firstObject as? NSDictionary {
                if let message = dictIndxZero.object(forKey: "message") as? String {
//                    Utility.showAlert("", message: message, vc: vc)
                    UtilityClass.showAlert(AppName, message: message, vc: vc ?? UIViewController())                }
                else if let msg = dictIndxZero.object(forKey: "msg") as? String {
//                    Utility.showAlert("", message: msg, vc: vc)
                    UtilityClass.showAlert(AppName, message: msg, vc: vc ?? UIViewController())                }
                else if let msg = dictIndxZero.object(forKey: "message") as? [String] {
//                    Utility.showAlert("", message: msg.first ?? "", vc: vc)
                    UtilityClass.showAlert(AppName, message: msg.first ?? "", vc: vc ?? UIViewController())                }
            }
            else if let msg = resAry as? [String] {
//                Utility.showAlert("", message: msg.first ?? "", vc: vc)
                UtilityClass.showAlert(AppName, message: msg.first ?? "", vc: vc ?? UIViewController())             }
        }
    }
    
    /// mask example: `+X (XXX) XXX-XXXX`
    class func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    class func imageGet(url : String , img:UIImageView , _ IndClr : UIColor = UIColor.green){
         img.kf.indicatorType = .activity
         let activity =  img.kf.indicator?.view as! UIActivityIndicatorView
        activity.color = UIColor.green

         img.kf.indicator?.startAnimatingView()
         let url = URL(string:(url))
         img.kf.setImage(with: url, placeholder: nil, options: [], progressBlock: nil) { (response) in

             img.kf.indicator?.stopAnimatingView()
         }
     }
    
    class func getDonationRemaining(Total:Double,Received:Double) -> Double{
         let remaining  = Total - Received
        return remaining.truncate(places: 1)
        
    }
    
    //Calucate percentage based on given values
    class func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100
    }

    class func dateTimeStatus(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let dt = dateFormatter.date(from: date) {
            let userFormatter = DateFormatter()
            userFormatter.dateStyle = .medium // Set as desired
            userFormatter.timeStyle = .medium // Set as desired

            return userFormatter.string(from: dt)
        } else {
            return "Unknown date"
        }
    }


    
}


//class Connectivity {
//    class func isConnectedToInternet() ->Bool {
//        return NetworkReachabilityManager()!.isReachable
//    }
//}

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

extension NSNumber {
    func getPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0 // You can set what you want
        return formatter.string(from: self)!
    }
}


