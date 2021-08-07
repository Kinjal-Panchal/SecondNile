//
//  Constants.swift
//  Virtuwoof Pet
//
//  Created by Hiral Jotaniya's iMac on 02/10/19.
//  Copyright © 2019 Hiral Jotaniya's iMac. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

var user_defaults = UserDefaults.standard
let keywindow = UIApplication.shared.keyWindow
let appDel = UIApplication.shared.delegate as! AppDelegate

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let KAPPVesion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

let AppName = "Danfo-Rider"
let currency = "$"

let APPURL = "itms-apps://itunes.apple.com/app/id1540228344"

let GoogleServiceApiKey = "AIzaSyC8mqmVkKtLYxti361nFOT9FErG64BzYI4"

let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
let TEXTFIELD_MaximumLimit = 25
let TEXTFIELD_MinimumLimit = 2

func getVectorImageFromAPI()->UIImageView{
    let api_vector = UIImageView()
   api_vector.sd_setImage(with: URL(string: "http://qwnched.excellentwebworld.in/assets/images/default_user.png"))
    return api_vector
}

let skeletonAnimationDirection = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
let skeletonBackgroundColor = SkeletonGradient(baseColor: UIColor.appColor(.themeGrayGradientFrst))// UIColor.white.withAlphaComponent(0.25))

struct DeviceType {
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

extension Notification.Name {
    static let notificationBadge = Notification.Name("notificationBadge")
    static let didReceiveData = Notification.Name("gotPushOfChat")
    static let didProfileDataUpdate = Notification.Name("didProfileDataUpdate")
}
