//
//  RegisterVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import UIKit

class RegisterVC: BaseVC {


  //MARK:- ====== Outlets =====
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnAlreadyAccount: UIButton!
    @IBOutlet var viewCollection: [UIView]!
    
    
    //MARK:- =====Variables ======
    var registerUserModel = LoginRegisterUserModel()
    var donationReqModel = DonationRequestModel()
    var isFromDonate = false
    var isFromProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpViews()
        // Do any additional setup after loading the view.
    }



   //MARK:- ====== View method Setup =========
   func setUpViews()
   {

    txtPhone.delegate = self
    txtFullName.delegate = self
    txtEmail.delegate = self
    txtPassword.delegate = self
    txtNickName.delegate = self
    btnAlreadyAccount.titleLabel?.font = CustomFont.MuseoSans_500.returnFont(FontSize.size16.rawValue)
    if isFromProfile == true {
        self.navigationController?.navigationBar.isTranslucent = true
    }
    UtilityClass.attributBtnSetup(btn: btnAlreadyAccount, FullString: "Already have an account? LOGIN", attributeText: "LOGIN")
   }
    

    //MARK:- ====== Btn Action Register ======
    @IBAction func btnActionRegister(_ sender: UIButton) {
        
        if validation() {
            let number = txtPhone.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
              registerUserModel.registerVC = self
               self.registerUserModel.registerRequestModel = RegisterRequestModel(name: txtFullName.text, nick_name: txtNickName.text, email: txtEmail.text, phone:number, password: txtPassword.text)
            registerUserModel.webserviceCallRegister(isFromDonate: isFromDonate, donationReqModel: donationReqModel)
           }
        
    }


    //MARK:- ====== Btn Action Login ======
    @IBAction func btnActionLogin(_ sender: UIButton) {
        if isFromProfile || isFromDonate{
            let loginVC : LoginVC = LoginVC.instantiate(appStoryboard: .Auth)
            
            loginVC.isFromDonate = isFromDonate
            loginVC.donationReqModel = donationReqModel
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    //MARK:- ==== Validation ======
    func validation()->Bool{
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
        let fullName = txtFullName.validatedText(validationType: ValidatorType.requiredField(field: txtFullName.placeholder ?? ""))
        let nickname =  txtNickName.validatedText(validationType: ValidatorType.requiredField(field: txtNickName.placeholder ?? ""))
        let phone = txtPhone.validatedText(validationType: ValidatorType.phone)
        let password = txtPassword.validatedText(validationType: ValidatorType.password)
        
        if (!fullName.0){
            AlertMessage.showMessageForError(fullName.1)
            return fullName.0
        }else if (!nickname.0){
            AlertMessage.showMessageForError(nickname.1)
            return nickname.0
        }else if(!checkEmail.0)
        {
            AlertMessage.showMessageForError(checkEmail.1)
            return checkEmail.0
        }
        else if (!phone.0){
            AlertMessage.showMessageForError(phone.1)
            return phone.0
        }
        else if (!password.0){
            AlertMessage.showMessageForError(password.1)
            return password.0
        }

        return true
    }
    
}

//MARK:- ===== Textfield delegate =======
extension RegisterVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtFullName {
            for i in viewCollection {
                if i.tag == 1 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtFullName)
                }
            }
        }
        else if textField == txtNickName {
            for i in viewCollection {
                if i.tag == 2{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtNickName)
                }
            }
        }
        else if textField == txtEmail {
            for i in viewCollection {
                if i.tag == 3 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtEmail)
                }
            }
        }
        else if textField == txtPhone {
            for i in viewCollection {
                if i.tag == 4{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtPhone)
                }
            }
        }
        else if textField == txtPassword {
            for i in viewCollection {
                if i.tag == 5{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtPassword)
                }

            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtFullName {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 1 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtFullName)
                    }
                }
            }

        }
        if textField == txtNickName {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 2 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtNickName)
                    }
                }
            }

        }
        if textField == txtEmail {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 3 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtEmail)
                    }
                }
            }

        }
        if textField == txtPhone {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 4 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtPhone)
                    }
                }
            }

        }
        else if textField == txtPassword {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 5 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtPassword)
                    }
                }
            }

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if textField == txtPhone {
            txtPhone.text = UtilityClass.format(with: "+X (XXX) XXX-XXXX", phone: newString)
            return false
        }
       return true

    }

    
}

 
