//
//  Colours.swift
//  Seconf Nile
//
//  Created by panchal kinjal on 16/07/21.
//

import Foundation
import UIKit

enum colors{
    case white,black,ThemeBGColour,lightTextColour,ThemeLightGray,ThemeDarkGrey,ThemeDarkBlue,ThemeLightBlue,ThemeTextViewBG,ThemeLightDateText


    var value:UIColor{
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .ThemeBGColour:
            return UIColor(hexString:"#ECF6F8")
        case.lightTextColour:
            return UIColor(hexString:"#A7A7A7")
        case .ThemeTextViewBG:
            return UIColor(hexString:"#F6F7F9")
        case .ThemeLightGray :
            return UIColor(hexString:"#E5E5E5")
        case .ThemeDarkGrey :
            return UIColor(hexString: "#B9B9B9")
        case .ThemeDarkBlue :
            return UIColor(hexString: "#1549DC")
        case .ThemeLightBlue :
            return UIColor(hexString:"#1B9AFC")
        case .ThemeLightDateText : 
            return UIColor(hexString: "#A2A2A2")
        }
    }
}
