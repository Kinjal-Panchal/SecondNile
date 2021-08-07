//
//  CustomButton.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import Foundation
import UIKit

class ThemeButton: UIButton {

    @IBInspectable public var isSubmitButton: Bool = false
    @IBInspectable public var isLightGrayButton : Bool = false

 override func awakeFromNib() {
    super.awakeFromNib()

    if isSubmitButton == true
    {
        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.backgroundColor = colors.ThemeDarkBlue.value
        setTitleColor(UIColor.white, for: .normal)
    }
    else if isLightGrayButton == true {
        self.titleLabel?.font = CustomFont.MuseoSans_500.returnFont(FontSize.size16.rawValue)
        setTitleColor(colors.ThemeDarkGrey.value, for: .normal)
    }
    else
    {
        self.backgroundColor = UIColor.clear
        setTitleColor(colors.ThemeLightBlue.value, for: .normal)
        self.titleLabel?.font = CustomFont.MuseoSans_500.returnFont(FontSize.size16.rawValue)
    }

  }
}

class ThemeGradientButton: UIButton {


    public let buttongradient: CAGradientLayer = CAGradientLayer()

//    override var isSelected: Bool {  // or isHighlighted?
//        didSet {
//            updateGradientColors()
//        }
//    }

    func updateGradientColors() {
        let colors: [UIColor]


        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue);  self.setTitleColor(UIColor.white, for: .normal)
        colors = [UIColor(hexString: "#1B56EA"),UIColor(hexString: "#1549DC")]

        buttongradient.colors = colors.map { $0.cgColor }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateGradient()
    }

    func setupGradient() {
        buttongradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        buttongradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.layer.insertSublayer(buttongradient, at: 0)

        updateGradientColors()
    }

    func updateGradient() {
        buttongradient.frame = self.bounds

    }
}



class ThemGreenButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel?.font = CustomFont.MuseoSans_300.returnFont(FontSize.size16.rawValue)
        setTitleColor(UIColor.hexStringToUIColor(hex: "#23CB55"), for: .normal)
    }
}

class ThemeGrayButton : UIButton{

    override func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
        setTitleColor(UIColor.hexStringToUIColor(hex: "#969696"), for: .normal)
    }
}

class ThemeBlueButton : UIButton {

    @IBInspectable var isstyle700 : Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel?.font =  isstyle700 == false ? CustomFont.MuseoSans_500.returnFont(FontSize.size18.rawValue) : CustomFont.MuseoSans_700.returnFont(FontSize.size18.rawValue)
        setTitleColor(UIColor.hexStringToUIColor(hex: "#1B56EA"), for: .normal)

    }
}



class ButtonWithShadow: UIButton {


    override func awakeFromNib() {
        super.awakeFromNib()


//        let gradientColor = CAGradientLayer()
//            gradientColor.frame = self.frame
//            gradientColor.colors = [UIColor.blue.cgColor,UIColor.red.withAlphaComponent(1).cgColor]
//            self.layer.insertSublayer(gradientColor, at: 0)

        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.backgroundColor = colors.ThemeDarkBlue.value
        setTitleColor(UIColor.white, for: .normal)
        self.shadowRadius = 12

        self.addShadow(offset: CGSize.init(width: 0, height: 4), color: UIColor.hexStringToUIColor(hex: "#1D9DFB"), radius: 12, opacity: 0.5)
    }

//    override func draw(_ rect: CGRect) {
//        updateLayerProperties()
//    }
//
//    func updateLayerProperties() {
//        self.layer.cornerRadius = self.frame.height / 2
//        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
//        self.backgroundColor =  colors.ThemeDarkBlue.value
//        self.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#1646DB").cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 10.0
//        self.layer.masksToBounds = false
//        self.clipsToBounds = true
//    }

}


class LoginButtonWithShadow: UIButton {


    override func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.backgroundColor = UIColor.hexStringToUIColor(hex: "#29B0FD")
        setTitleColor(UIColor.white, for: .normal)
        self.shadowRadius = 12

        self.addShadow(offset: CGSize.init(width: 0, height: 4), color: UIColor.hexStringToUIColor(hex: "#1D9DFB"), radius: 12, opacity: 0.5)
    }

}

class CustomShadowButton: UIButton {

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!

        backgroundColor = UIColor.hexStringToUIColor(hex: "#1B56EA")
        self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.backgroundColor = colors.ThemeDarkBlue.value
        setTitleColor(UIColor.white, for: .normal)

    }

    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }

    func updateLayerProperties() {
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height / 2

        //superview is your optional embedding UIView
        if let superview = superview {
            superview.backgroundColor = UIColor.clear
            superview.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#1D9DFB40").cgColor;            superview.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12.0).cgPath
            superview.layer.shadowOffset = CGSize(width: 2.0, height: 5)
            superview.layer.shadowOpacity = 1
            superview.layer.shadowRadius = 4
            superview.layer.masksToBounds = true
            superview.clipsToBounds = false
        }
    }

}

class ThemeBlueRound : UIButton {

    @IBInspectable var isLightBlue : Bool = false
    @IBInspectable var isSize : Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

        if isLightBlue == true {
            self.layer.cornerRadius = self.layer.frame.height/2
            self.clipsToBounds = true
            self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size12.rawValue)
            self.backgroundColor = UIColor.hexStringToUIColor(hex: "#2BB0FC")
            setTitleColor(.white, for: .normal)
        }
        else {
            self.layer.cornerRadius = self.layer.frame.height/2
            self.clipsToBounds = true
            self.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(isSize == true ? 15.0 : FontSize.size12.rawValue)
            self.backgroundColor = UIColor.hexStringToUIColor(hex: "#1B56EA")
            setTitleColor(.white, for: .normal)
        }

    }

}
