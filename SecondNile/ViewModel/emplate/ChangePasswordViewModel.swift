//
//  ChangePasswordViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 01/08/21.
//

import Foundation

class ChangePasswordModel {
    
    weak var changePasswordVC : ChangePasswordVC? = nil
    
    var changePasswordReqModel = ChangePassRequestModel()
    
    
    //MARK:- ====== Webservice call Change Password =======
       func webserviceCallChangePassword(){
        
        changePasswordReqModel.old_password = changePasswordVC?.txtOldPassword.text
        changePasswordReqModel.new_password = changePasswordVC?.txtNewPassword.text
        changePasswordReqModel.new_confirm_password = changePasswordVC?.txtConfirmPassword.text
        
        UtilityClass.showHUD()
        WebServiceSubClass.ChangePassword(reqModel: changePasswordReqModel) { (status, response, error) in
            UtilityClass.hideHUD()
            if self.changePasswordVC != nil {
                if status {
                    print(response)
                    AlertMessage.showMessageForSuccess(response?.message ?? "")
                    self.changePasswordVC?.navigationController?.popViewController(animated: true)
                }
                else {
                    if let changePassVC = self.changePasswordVC{
                      UtilityClass.showAlertOfAPIResponse(param: error, vc: changePassVC)
                 }
                }
            }
            
          }
        }
    }

class ForgotPasswordViewModel {
    
    weak var forgotPasswordVC : ForgotPasswordVC? = nil
    
     var forgotPasswordReqModel = ForgotPassRequestModel()
    
    
    //MARK:- ====== Webservice call Change Password =======
       func webserviceCallForgotPassword(){
        UtilityClass.showHUD()
        forgotPasswordReqModel.email = forgotPasswordVC?.txtEmail.text
        WebServiceSubClass.ForgotPassword(reqModel: forgotPasswordReqModel) { (status, response, error) in
            UtilityClass.hideHUD()
            if self.forgotPasswordVC != nil {
                if status {
                    print(response)
                    self.forgotPasswordVC?.navigationController?.popViewController(animated: true)
                }
            else {
                if let forgotPassVC = self.forgotPasswordVC{
                  UtilityClass.showAlertOfAPIResponse(param: error, vc: forgotPassVC)
             }
            }
            }
          }
       }
}
