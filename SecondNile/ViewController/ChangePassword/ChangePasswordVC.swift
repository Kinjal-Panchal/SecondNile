//
//  ChangePasswordVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import UIKit

class ChangePasswordVC: BaseVC {

   //MARK :- ====== Outlets ======
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet var viewCollection: [UIView]!
    

    //MARK:- ===== Variables =====
    var changePassUserModel = ChangePasswordModel()

    //MARK:- ===== View controller Life Cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOldPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtNewPassword.delegate = self
        navigationBarSetup()
        
    }


    //MARK:- ==== NavigationBar Setup ====
    func navigationBarSetup(){
        self.setNavBarWithMenuORBack(Title: "Change Password", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
    }


    //MARK:- === Btn Action Update ======
    @IBAction func btnActionUpdate(_ sender: UIButton) {
        let isvalidator = validation()
        if isvalidator.1 == false{
           AlertMessage.showMessageForError(isvalidator.0)
       }
       else{
        changePassUserModel.changePasswordVC = self
        changePassUserModel.webserviceCallChangePassword()
      
       }

    }
    
    //MARK:- ====== Validation ======
    func validation()->(String,Bool){
        var isValid = true
        var msg = ""
        if (txtOldPassword.text?.isEmptyOrWhitespace())!{
            msg = "Please enter your current password."
        }
        else if (txtNewPassword.text?.isEmptyOrWhitespace())!{
            msg = "Please enter your new password."
        }
         else if txtNewPassword.text!.count <= 7{
            msg = "Password must contain at least 8 characters."
         }
         else if (txtConfirmPassword.text?.isEmptyOrWhitespace())!{
             msg = "Please enter confirm password."
         }
         else if txtNewPassword.text != txtConfirmPassword.text{
            msg = "Password and confirm password must be same."
        }
        isValid = msg == "" ? true : false
        return(msg,isValid )
    }
    


}

extension  ChangePasswordVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtOldPassword {
            for i in viewCollection {
                if i.tag == 1 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtOldPassword)
                }
            }
        }
        else if textField == txtNewPassword {
            for i in viewCollection {
                if i.tag == 2 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtNewPassword)
                }

            }
        }
        else if textField == txtConfirmPassword {
            for i in viewCollection {
                if i.tag == 3 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtConfirmPassword)
                }

            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtOldPassword {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 1 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtOldPassword)
                    }
                }
            }

        }
        else if textField == txtNewPassword {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 1 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtNewPassword)
                    }
                }
            }

        }

        else if textField == txtConfirmPassword {
            for i in viewCollection {
                if i.tag == 2 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtConfirmPassword)
                }

            }
        }
    }
}

