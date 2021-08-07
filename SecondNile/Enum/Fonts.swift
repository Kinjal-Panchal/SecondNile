import Foundation
import UIKit
enum CustomFont{
    case MuseoSans_100,MuseoSans_300,MuseoSans_500,MuseoSans_700
    func returnFont(_ font:CGFloat)->UIFont{
        switch self {
        case .MuseoSans_100:
            return UIFont(name: "MuseoSans-100", size: font)!
        case .MuseoSans_300:
            return UIFont(name: "MuseoSans-300", size: font)!
        case .MuseoSans_500:
            return UIFont(name: "MuseoSans-500", size: font)!
        case .MuseoSans_700:
            return UIFont(name: "MuseoSans-700", size: font)!
        }
    }
}

enum FontSize : CGFloat
{
    case size10 = 10.0
    case size8 = 8.0
    case size12 = 12.0
    case size14 = 14.0
    case size16 = 16.0
    case size18 = 18.0
    case size28 = 28.0
    case size20 = 20.0
    case size15 = 15.0
    case size22 = 22.0
    case size13 = 13.0
}


