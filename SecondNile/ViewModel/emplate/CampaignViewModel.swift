//
//  CampaignViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 03/08/21.
//

import Foundation

class CampaignViewModel {
    
    //MARK:- ======= Variables =====
    weak var campaignListVc : CampaginVC? = nil
    var currentCampaign : Compaign!
    var arrCompleted = [Compaign]()
    
    //MARK:- ===== Webservice Call CampaignList ====
    func webserviceCallCampaignList(){

            UtilityClass.showHUD()
            let keyPath =  ApiKey.campaignList.rawValue
        WebServiceSubClass.CampaignList(keyPath: keyPath) { (status, response,error) in
            UtilityClass.hideHUD()
            if self.campaignListVc != nil {
                if status {
                    if let objData = response?.data {
                        if let objCurrent = objData.active {
                            self.currentCampaign = objCurrent
                        }
                        if objData.completed?.count != 0 {
                            if let obj = objData.completed {
                                self.arrCompleted = obj
                            }
                        }
                    }
                    self.campaignListVc?.tblCampagin.reloadData()
                }
                else {
                    if let campaignVC = self.campaignListVc{
                        UtilityClass.showAlertOfAPIResponse(param: error, vc: campaignVC)
                   }
                }
                
            }
        }
    }
}

