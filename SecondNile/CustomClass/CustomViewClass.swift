//
//  CustomViewClass.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import Foundation
import UIKit
import LinearProgressView
import WaveAnimationView

//MARK:- ==== Background View =====
class ThemeBGView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = colors.ThemeBGColour.value

    }
}
//MARK :- ===== Textfield Rounded view =====
class ThemeRoundViewTextfield : UIView{

    @IBInspectable var isRounded : Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor =  isRounded == true ? colors.white.value : colors.ThemeTextViewBG.value
        self.layer.cornerRadius = isRounded == true ? 10  : self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderColor =  isRounded == true ? UIColor.clear.cgColor : UIColor.hexStringToUIColor(hex: "#E5E5E5").cgColor
        self.layer.borderWidth = 1.0
        
    }
}

class ThemeDonatorDateView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hexString: "#EDEEEF")
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true


    }
}

class ThemeRoundCornerView: UIView {

    @IBInspectable var Radius : CGFloat = 10

    override func awakeFromNib() {
            super.awakeFromNib()

            DispatchQueue.main.async {
                self.layoutIfNeeded()
                self.roundCorners([.topLeft, .topRight], radius: self.Radius)
                self.clipsToBounds = true
            }
    }
}

class ThemeRoundCornerDonatorView : UIView {
    override func awakeFromNib() {
            super.awakeFromNib()

            DispatchQueue.main.async {
                self.layoutIfNeeded()
                self.layer.cornerRadius = 10
                self.clipsToBounds = true
                self.layer.borderWidth = 1
                self.borderColor = UIColor.hexStringToUIColor(hex: "#E5E9ED")
            }
    }
}

class ProgressBarView : LinearProgressView {
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.trackColor = UIColor.hexStringToUIColor(hex: "#209FFC")
        self.layer.borderColor = UIColor.hexStringToUIColor(hex: "#40D3FE").cgColor
        self.layer.borderWidth = 1
        self.barColor = UIColor.white
       

    }
}

class HomeRoundView : UIView{

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.hexStringToUIColor(hex: "#CBCFD3").cgColor

    }
}

class ViewWave : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 181/255, green: 238/255, blue: 251/255, alpha: 1.0)
        self.layer.borderWidth = 2
        self.borderColor = colors.ThemeDarkBlue.value
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
}

class AboutViewround : UIView {

    @IBInspectable var Radius : CGFloat = 10
    @IBInspectable var bottomLeft : Bool = false

    override func awakeFromNib() {
            super.awakeFromNib()

            DispatchQueue.main.async {
                self.layoutIfNeeded()
                self.backgroundColor = UIColor.hexStringToUIColor(hex: "#ECF6F8")
                if self.bottomLeft == true {
                    self.roundCorners([.bottomRight], radius: self.Radius)
                }
                else{
                    self.roundCorners([.topLeft], radius: self.Radius)

                }

                self.clipsToBounds = true
            }
    }
}

class dashedLine : UIView {

    override func awakeFromNib() {
            super.awakeFromNib()
        self.addDashedBorder()

    }


}
extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }

    
}

extension UIView {

    func addDashedBorder() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hexString: "#D2D2D2").cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
