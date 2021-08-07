//
//  ProfileViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 01/08/21.
//

import Foundation

class  ProfileViewModel  {
    
    //MARK:- ======= Variables =====
    weak var profileVc : ProfileVC? = nil
    weak var editprofileVc : EditProfileVC? = nil
    var profileData : ProfileDetails?
    var profileRequestModel : ProfileUpdateRequestModel?
    var notificationReqModel : NotificationRequestModel?
    
    
    //MARK:- ======= Webservice Call profile =====
    func webserviceCallProfile(){
            UtilityClass.showHUD()
            let keyPath =  ApiKey.profile.rawValue
        WebServiceSubClass.Profile(keyPath: keyPath) { status, response, error in
            UtilityClass.hideHUD()
            if self.profileVc != nil {
                if status {
                    print(response?.data)
                    self.profileData = response?.data
                    print(self.profileData)
                    self.profileVc?.lblName.text = self.profileData?.name
                    self.profileVc?.tblmenuList.reloadData()
                }
                else {
                    if let profileVc = self.profileVc{
                       UtilityClass.showAlertOfAPIResponse(param: error, vc: profileVc)
                   }
                }
            }
        }
    }
    
    //MARK:- ======= Webservice Call Update profile =====
    func webserviceCallupdateProfile(){
        if let reqModel = profileRequestModel {
            UtilityClass.showHUD()
            WebServiceSubClass.updateProfile(reqModel: reqModel) { (status, response, error) in
                UtilityClass.hideHUD()
                if self.editprofileVc != nil {
                    if status {
                        print(response)
                        self.editprofileVc?.navigationController?.popViewController(animated: true)
                        NotificationCenter.default.post(name: NotificationObeserverKeys.ProfiledataRefresh, object: nil, userInfo: nil)
                    }
                    else {
                        if let profileVc = self.profileVc{
                           UtilityClass.showAlertOfAPIResponse(param: error, vc: profileVc)
                       }
                    }
                }
            }
        }
    }
    
    
    //MARK:- ======= Webservice Call Channge Notification =====
    func webserviceCallChangenotificationStatus(){
      if let req = notificationReqModel {
          UtilityClass.showHUD()
          WebServiceSubClass.NotificationStatusChange(reqModel: notificationReqModel!) { status, response, error in
                UtilityClass.hideHUD()
                if status {
                    print(response!)
                }
                else {
                    if let profileVc = self.profileVc{
                       UtilityClass.showAlertOfAPIResponse(param: error, vc: profileVc)
                   }
                }
            }
        }
            
    }
    
    //MARK:- ====== WebserviceCall Logout ======
    func webServiceCallLogout(){
        UtilityClass.showHUD()
        let keyPath =  ApiKey.logout.rawValue
        let req = commonRequestModel()
        
        WebServiceSubClass.Logout(reqModel: req) { (status, response, error) in
            UtilityClass.hideHUD()
                if status{
                    user_defaults.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    appDel.SetLogout()
                }else{
                    if let profilevc = self.profileVc{
                        UtilityClass.showAlertOfAPIResponse(param: error, vc: profilevc)
                    }
                }
        }
    }
    
}
