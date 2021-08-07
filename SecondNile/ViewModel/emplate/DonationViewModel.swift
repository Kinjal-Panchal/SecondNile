//
//  DonationViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 03/08/21.
//

import Foundation

class DonationViewModel {
    
    weak var donationVC : SuccessPopupVC? = nil
    var donationRequestModel = DonationRequestModel()
    
    //MARK:- ====== Webservice call Donation =======
      func webserviceCallDonation(){
              UtilityClass.showHUD()
            WebServiceSubClass.donation(reqModel: donationRequestModel) { (status, response,error ) in
                UtilityClass.hideHUD()
                if self.donationVC != nil {
                    if status {
                        NotificationCenter.default.post(name: NSNotification.Name("DataRefresh"), object: nil)
                        
                    }
                    else {
                        if let donationVC = self.donationVC{
                            UtilityClass.showAlertOfAPIResponse(param: error, vc: donationVC)
                        }
                    }
                }
              }
            
          }
    
    
}
