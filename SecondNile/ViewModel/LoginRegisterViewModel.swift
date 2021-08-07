//
//  LoginRegisterViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 31/07/21.
//

import Foundation

class LoginRegisterUserModel {
    
    weak var registerVC : RegisterVC? = nil
    weak var loginVC : LoginVC? = nil
    var registerRequestModel : RegisterRequestModel?
    
    
  //MARK:- ====== Webservice call Register =======
    func webserviceCallRegister(isFromDonate:Bool ,donationReqModel : DonationRequestModel){

        if let reqModel = self.registerRequestModel{

            UtilityClass.showHUD()
            WebServiceSubClass.Registration(reqModel: reqModel) { (status,response,error) in
                UtilityClass.hideHUD()
                    if self.registerVC != nil {
                      if status {
                        UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                        print(response?.data.token ?? "")
                        Singletone.shared.userProfileData = response!.data
                        Singletone.shared.BearerDeviceToken = response!.data.token ?? ""
                        user_defaults.setUserData()
                        if isFromDonate == true {
                            let confirmationVC:SuccessPopupVC = SuccessPopupVC.instantiate(appStoryboard: .main)
                            confirmationVC.donationviewModel.donationRequestModel = donationReqModel
                             confirmationVC.navToDashboard = {
                                print(Appdel.window?.rootViewController)
                                Appdel.GoToHome()
                             }
                            self.registerVC?.present(confirmationVC, animated: true, completion: nil)
                        }
                        else {
                            Appdel.GoToHome()
                        }
                        
                   }
                  else {
                      if let registervc = self.registerVC{
                          UtilityClass.showAlertOfAPIResponse(param: error, vc: registervc)
                      }
                  }
              }
            }
        }

    }
    
    
   //MARK:- ====== Webservice call Login ======
    func webserviceCallLogin(isFromDonate:Bool ,donationReqModel : DonationRequestModel ){
       
        let loginReq = LoginRequestModel()
        loginReq.email = loginVC?.txtEmail.text ?? ""
        loginReq.password = loginVC?.txtPassword.text ?? ""
    
            UtilityClass.showHUD()
            WebServiceSubClass.Login(reqModel: loginReq) { (status, response, error) in
                UtilityClass.hideHUD()
              if self.loginVC != nil {
                if status {
                    UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    print(response?.data.token ?? "")
                    Singletone.shared.userProfileData = response?.data
                    Singletone.shared.BearerDeviceToken = response?.data.token ?? ""
                    user_defaults.setUserData()
                    if isFromDonate == true {
                        let confirmationVC:SuccessPopupVC = SuccessPopupVC.instantiate(appStoryboard: .main)
                        confirmationVC.donationviewModel.donationRequestModel = donationReqModel
                         confirmationVC.navToDashboard = {
                            print(Appdel.window?.rootViewController)
                            Appdel.GoToHome()
                         }
                        self.loginVC?.present(confirmationVC, animated: true, completion: nil)
                    }
                    else {
                        Appdel.GoToHome()
                    }
                }
                else {
                    if let loginVC = self.loginVC{
                        UtilityClass.showAlertOfAPIResponse(param: error, vc: loginVC)
                    }
                }
              }
            }
        }
    
        
}

