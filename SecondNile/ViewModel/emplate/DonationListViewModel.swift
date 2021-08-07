//
//  DonationListViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 02/08/21.
//

import Foundation

class  DonationListViewModel  {
    
    //MARK:- ======= Variables =====
    weak var DonationPageVc : DonateGalleryVC? = nil
    var donationdataResponse : DonationData?
    
    //MARK:- ===== Webservice Call DonatePage ====
    func webserviceCallDonatePage(){

            UtilityClass.showHUD()
            let keyPath =  ApiKey.DonatePage.rawValue
          WebServiceSubClass.DonationPage(keyPath: keyPath) { (status, response, error) in
            UtilityClass.hideHUD()
            if self.DonationPageVc != nil {
                if status {
                    if let objdonateData = response?.data {
                        self.donationdataResponse = objdonateData
                        
                        self.DonationPageVc?.colOfDonateInfo.reloadData()
                    }
              }
            else {
                if let donationpage = self.DonationPageVc{
                    UtilityClass.showAlertOfAPIResponse(param: error, vc: donationpage)
               }
            }
            }
        }
    }
}
