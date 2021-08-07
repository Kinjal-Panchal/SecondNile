//
//  LoginVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import UIKit

class LoginVC: BaseVC {

    //MARK: -======== Outlets =======
    @IBOutlet var viewCollectionTextfield: [UIView]!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnDontHaveAccnt: UIButton!


    //MARK:- ======= Variables ========
     var isFromDonate = false
     var loginUserModel = LoginRegisterUserModel()
     var donationReqModel = DonationRequestModel()
     var isFromProfile = false
     var isFromLogout = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        setUpViews()
    }
    
    //MARK:- ===== Btn Action Forgot Password =====
    @IBAction func btnActionForgotPassword(_ sender: UIButton) {
        let forgotpasswordVC = ForgotPasswordVC.instantiate(appStoryboard: .Auth)
        self.navigationController?.pushViewController(forgotpasswordVC, animated: true)
    }

    //MARK:- ===== Btn Action Don't have ana ccount =====
    @IBAction func btnActiondonthaveanAccount(_ sender: UIButton) {
        if isFromProfile || isFromDonate || isFromLogout{
            let registerVC:RegisterVC = RegisterVC.instantiate(appStoryboard: .Auth)
            
            registerVC.isFromDonate = isFromDonate
            registerVC.donationReqModel = donationReqModel
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }


    //MARK:- ===== Btn Action Login =====
    @IBAction func btnActionLogin(_ sender: UIButton) {

        if validation() {
            loginUserModel.loginVC = self
            loginUserModel.webserviceCallLogin(isFromDonate: isFromDonate , donationReqModel : donationReqModel )
        }
        
    }


    //MARK:- ====== View method Setup =========
   func setUpViews()
   {
    if isFromProfile == true {
        self.navigationController?.navigationBar.isTranslucent = true
    }
    btnDontHaveAccnt.titleLabel?.font = CustomFont.MuseoSans_500.returnFont(FontSize.size16.rawValue)
    UtilityClass.attributBtnSetup(btn: btnDontHaveAccnt, FullString: "Don’t have an account? REGISTER", attributeText: "REGISTER")
   }
    
    
    //MARK:- ==== Validation ======
    func validation()->Bool{
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
        let password = txtPassword.validatedText(validationType: ValidatorType.password)
        if(!checkEmail.0)
        {
            AlertMessage.showMessageForError(checkEmail.1)
            return checkEmail.0
        }
        else if (!password.0){
            AlertMessage.showMessageForError(password.1)
            return password.0
        }
        return true
    }
    

}



extension LoginVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in viewCollectionTextfield {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtEmail {
            for i in viewCollectionTextfield {
                if i.tag == 1 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtEmail)
                }
            }
        }
        else if textField == txtPassword {
            for i in viewCollectionTextfield {
                if i.tag == 2 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtPassword)
                }

            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in viewCollectionTextfield {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtEmail {
            if textField.text != "" {
                for i in viewCollectionTextfield {
                    if i.tag == 1 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtEmail)
                    }
                }
            }

        }
        else if textField == txtPassword {
            if textField.text != "" {
                for i in viewCollectionTextfield {
                    if i.tag == 2 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtPassword)
                    }
                }
            }

        }
    }
}
