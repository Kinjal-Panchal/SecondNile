//
//  CustomTextfield.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import Foundation
import UIKit

class ThemeTextfield : UITextField {
    
    @IBInspectable var isPrice : Bool = false
    @IBInspectable var image: UIImage? {
        didSet
        {
            setRightViewDropDown(image: image ?? UIImage())
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()

        if isPrice == true {
            self.placeholderColour(Colour:UIColor.hexStringToUIColor(hex: "#969696") , PlaceHolder: self.placeholder ?? "")
            self.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
            self.textColor = UIColor.hexStringToUIColor(hex: "#969696")
        }
        else {
            self.font = CustomFont.MuseoSans_500.returnFont(FontSize.size16.rawValue)
            self.textColor = colors.ThemeDarkBlue.value
        }
        
    }
    
    func setRightViewDropDown(image : UIImage)
    {
        let arrow = UIImageView(image:image)
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0, y: 0, width: size.width + 10.0, height: size.height)
        }
        arrow.contentMode = UIView.ContentMode.center
        self.rightView = arrow
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if self.tag == 101{
            if action == #selector(UIResponderStandardEditActions.paste(_:)) ||  action == #selector(UIResponderStandardEditActions.copy(_:)) ||  action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||  action == #selector(UIResponderStandardEditActions.select(_:)) ||  action == #selector(UIResponderStandardEditActions.cut(_:)) ||  action == #selector(UIResponderStandardEditActions.delete(_:))  {
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
