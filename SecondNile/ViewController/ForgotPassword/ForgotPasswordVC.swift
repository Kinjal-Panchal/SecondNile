//
//  ForgotPasswordVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import UIKit

class ForgotPasswordVC: BaseVC {


    //MARK:- ====== Outlets =====
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewTextfield: UIView!

    //MARK:- ====== Variables =====
    var forgotPassModel = ForgotPasswordViewModel()

    //MARK:- ==== View Controller Life Cycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        navigationBarSetup()

    }


    //MARK:- ====== NavigationBar Setup =====
    func navigationBarSetup(){
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithMenuORBack(Title: "", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: true)
    }
    
    
    //MARK:- ==== Validation ======
    func validation()->Bool{
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
       
         if(!checkEmail.0)
        {
            AlertMessage.showMessageForError(checkEmail.1)
            return checkEmail.0
        }

        return true
    }

    //MARK:- ====== Btn Action Done ======
    @IBAction func btnActionDone(_ sender: UIButton) {
        if validation() {
            forgotPassModel.forgotPasswordVC = self
            forgotPassModel.webserviceCallForgotPassword()
        }
        
    }



}

extension ForgotPasswordVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UtilityClass.selecteUI(view: viewTextfield, Selected: false, textfield: textField)
       
        if textField == txtEmail {
            if textField.text != "" {
             UtilityClass.selecteUI(view: viewTextfield, Selected: true, textfield: txtEmail)
            }
         }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UtilityClass.selecteUI(view: viewTextfield, Selected: true, textfield: txtEmail)
       
    }
}
