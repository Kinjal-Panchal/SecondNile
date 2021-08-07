//
//  EditProfileVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import UIKit

class EditProfileVC: BaseVC {

    //MARK:- =====Outlets =======
    @IBOutlet var txtFullName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet var collectionOfTextfield: [UITextField]!
    
    //MARK:- ======== Variables =====
    var profileUserModel = ProfileViewModel()
    
    
    //MARK:- ===== view Controller LifeCycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
        navigationBarSetup()
    }

    //MARK:- ===== Nqvigation Bar Setup =====
    func navigationBarSetup(){
        setNavBarWithMenuORBack(Title: "Edit Profile", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
        txtEmail.delegate = self
        txtPhone.delegate = self
        txtFullName.delegate = self
        txtNickName.delegate = self
    }

    //MARK:- ==== DataSetup =====
    func dataSetup(){
        for i in viewCollection {
            for j in collectionOfTextfield {
                UtilityClass.selecteUI(view: i, Selected: false, textfield:j)
            }
        }
        txtEmail.text = profileUserModel.profileData?.email
        txtPhone.text = UtilityClass.format(with: "+X (XXX) XXX-XXXX", phone: profileUserModel.profileData?.phone ?? "")
        txtNickName.text  = profileUserModel.profileData?.nickName
        txtFullName.text = profileUserModel.profileData?.name
    }
    
   

    //MARK:- ===== Btn Action update =====
    @IBAction func btnActionUpdate(_ sender: UIButton) {
        if validation() {
            let number = txtPhone.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            self.profileUserModel.editprofileVc = self
            self.profileUserModel.profileRequestModel = ProfileUpdateRequestModel(name: txtFullName.text ?? "", nick_name: txtNickName.text ?? "", email: txtEmail.text ?? "", phone: number)
            profileUserModel.webserviceCallupdateProfile()
        }
    }
    
    //MARK:- ==== Validation ======
    func validation()->Bool{
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
        let fullName = txtFullName.validatedText(validationType: ValidatorType.requiredField(field: txtFullName.placeholder ?? ""))
        let nickname =  txtNickName.validatedText(validationType: ValidatorType.requiredField(field: txtNickName.placeholder ?? ""))
        let phone = txtPhone.validatedText(validationType: ValidatorType.phone)
        
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

        return true
    }
    



}
extension  EditProfileVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtNickName {
            for i in viewCollection {
                if i.tag == 1 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtNickName)
                }
            }
        }
        else if textField == txtFullName {
            for i in viewCollection {
                if i.tag == 2 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtFullName)
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
                if i.tag == 4 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtPhone)
                }

            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtNickName {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 1 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtNickName)
                    }
                }
            }

        }
        if textField == txtFullName {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 2 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtFullName)
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
        else if textField == txtPhone {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 4 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtPhone)
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

