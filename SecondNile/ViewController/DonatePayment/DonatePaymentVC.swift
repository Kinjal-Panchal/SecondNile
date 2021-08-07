//
//  DonatePaymentVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 24/07/21.
//

import UIKit

class DonatePaymentVC: BaseVC {

    //MARK: ====== Outlets ======
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var txtCollection: [UITextField]!
    
    //MARK:- ===== Variables =======

    var donationReqModel = DonationRequestModel()
    //     var selectedPlan = String()
//     var selectedammount = String()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in txtCollection{
            i.delegate = self
        }
        self.navigationController?.navigationBar.isHidden = false
       setNavBarWithMenuORBack(Title: "Donate", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)

    }

    //MARK:- ===== Btn Action Donate Monthly =====
    @IBAction func btnActionDonateMonthly(_ sender: UIButton) {
        
        if validation() {
            donationReqModel.billing_address_1 = txtAddress1.text
            donationReqModel.billing_address_2 = txtAddress2.text
            donationReqModel.country = txtCountry.text
            donationReqModel.state = txtState.text
            let number = txtPhone.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            donationReqModel.phone = number
            donationReqModel.zipcode = txtZipCode.text
            if UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil,UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as! Bool
                        {
                            if user_defaults.getUserData() != nil{
                                let userdata = user_defaults.getUserData()
                                Singletone.shared.userProfileData = userdata
                                Singletone.shared.BearerDeviceToken = userdata?.token ?? ""
                                navigateToConfirmPayment(donationRequestModel:donationReqModel)
                            }
                      }
                      else {
                        Appdel.GoToLogin(isFromDonate: true, donationReqModel, isfromLogout: false)
                    }
                }
        
        
//        if selectedPlan == "Give Monthly" {
//
//            if UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil,UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as! Bool
//            {
//                if user_defaults.getUserData() != nil{
//                    let userdata = user_defaults.getUserData()
//                    Singletone.shared.userProfileData = userdata
//                    Singletone.shared.BearerDeviceToken = userdata?.token ?? ""
//                    navigateToConfirmPayment()
//                }
//          }
//          else {
//            Appdel.GoToLogin(isFromDonate: true)
//        }
//       }
//        else {
//            navigateToConfirmPayment()
//        }
    }
        
    //MARK:- ====== Navigate to confirm paymentVC ====
    func navigateToConfirmPayment(donationRequestModel : DonationRequestModel){
         
            let confirmationVC:SuccessPopupVC = SuccessPopupVC.instantiate(appStoryboard: .main)
            confirmationVC.donationviewModel.donationRequestModel = donationRequestModel
             confirmationVC.navToDashboard = {
                print(Appdel.window?.rootViewController)
                self.navigationController?.popToRootViewController(animated: true)
             }
            self.present(confirmationVC, animated: true, completion: nil)
        }
        
    
    //MARK:- ==== Validation ======
    func validation()->Bool{
        let address1 = txtAddress1.validatedText(validationType: ValidatorType.requiredField(field: txtAddress1.placeholder ?? ""))
        let address2 =  txtAddress2.validatedText(validationType: ValidatorType.requiredField(field: txtAddress2.placeholder ?? ""))
        let country = txtCountry.validatedText(validationType: ValidatorType.requiredField(field: txtCountry.placeholder ?? ""))
        let state = txtState.validatedText(validationType: ValidatorType.requiredField(field: txtState.placeholder ?? ""))
        let zipCode = txtZipCode.validatedText(validationType: ValidatorType.requiredField(field: txtZipCode.placeholder ?? ""))
        let phone = txtPhone.validatedText(validationType: ValidatorType.phone)
        
        
        if (!address1.0){
            AlertMessage.showMessageForError(address1.1)
            return address1.0
        }else if (!address2.0){
            AlertMessage.showMessageForError(address2.1)
            return address2.0
        }
        else if (!country.0){
            AlertMessage.showMessageForError(country.1)
            return country.0
        }
        else if (!state.0){
            AlertMessage.showMessageForError(state.1)
            return state.0
        }
        else if (!zipCode.0){
            AlertMessage.showMessageForError(zipCode.1)
            return zipCode.0
        }
        else if (!phone.0){
            AlertMessage.showMessageForError(phone.1)
            return phone.0
        }

        return true
    }
    

}

//MARK:- ======= textfield delegate methods ======
extension DonatePaymentVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtAddress1 {
            for i in viewCollection {
                if i.tag == 1 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtAddress1)
                }
            }
        }
        else if textField == txtAddress2 {
            for i in viewCollection {
                if i.tag == 2{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtAddress2)
                }
            }
        }
        else if textField == txtCountry {
            for i in viewCollection {
                if i.tag == 3 {
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtCountry)
                }
            }
        }
        else if textField == txtState {
            for i in viewCollection {
                if i.tag == 4{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtState)
                }
            }
        }
        else if textField == txtZipCode {
            for i in viewCollection {
                if i.tag == 5{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtZipCode)
                }

            }
        }
        else if textField == txtPhone {
            for i in viewCollection {
                if i.tag == 5{
                    UtilityClass.selecteUI(view: i, Selected: true, textfield: txtPhone)
                }

            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in viewCollection {
            UtilityClass.selecteUI(view: i, Selected: false, textfield: textField)
        }
        if textField == txtAddress1 {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 1 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtAddress1)
                    }
                }
            }

        }
        if textField == txtAddress2 {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 2 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtAddress2)
                    }
                }
            }

        }
        if textField == txtCountry {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 3 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtCountry)
                    }
                }
            }

        }
        if textField == txtState {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 4 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtState)
                    }
                }
            }

        }
        else if textField == txtZipCode {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 5 {
                        UtilityClass.FillDataUI(view: i, Selected: true, textfield: txtZipCode)
                    }
                }
            }

        }
        else if textField == txtPhone {
            if textField.text != "" {
                for i in viewCollection {
                    if i.tag == 5 {
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
