//
//  HomeViewModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 01/08/21.
//

import Foundation

class HomeUserModel {
      
    weak var homeVC : HomeVC? = nil
    var homeDetails : HomeDetails?
    var tokenRequestModel : TokenRequestModel?
    
    
    //MARK:- ======= Webservice Call Home Screen =====
    func webserviceCallHomeScreen(showHud:Bool){
            if showHud {
                UtilityClass.showHUD()
            }
            
            let keyPath =  ApiKey.Home.rawValue
            WebServiceSubClass.Home(keyPath: keyPath) { (status, response, error) in
             UtilityClass.hideHUD()
                self.homeVC?.refreshControl.endRefreshing()
                if self.homeVC != nil {
                  if status {
                    print(response!)
                    self.homeDetails = response?.data
                    
                    self.homeVC?.tblListOfNileInfo.reloadData()
                    self.DataSetup(objDetails:self.homeDetails!)
                    
                }
             else {
                if let HomeVc = self.homeVC{
                    UtilityClass.showAlertOfAPIResponse(param: error, vc: HomeVc)
               }
            }
         }
        }
    }
    
    func DataSetup(objDetails:HomeDetails){
        let obj = objDetails.donation
        homeVC?.lblAmmount.text = "\(objDetails.openedWell ?? 0)"
        homeVC?.lblDescription.text = obj?.donationDescription
        homeVC?.lblTotalDonation.text = "$\(obj?.amount ?? "")"
        homeVC?.lblCampaignName.text = obj?.name
        UtilityClass.imageGet(url: obj?.fullImage ?? "" , img: (homeVC?.imgCampaign)!)
        let strRemaining =  UtilityClass.getDonationRemaining(Total: Double(obj?.amount ?? "0") ?? 0.0, Received: Double(obj?.receivedDonation ?? "0") ?? 0.0)
        homeVC?.lblRemainingDonation.text = "$\(strRemaining)"
        let percentage = UtilityClass.calculatePercentage(value: strRemaining, percentageVal: 1)
        
        homeVC?.waveSetup(Progress: Float(percentage))
    }
    
 //MARK:- ======webservice call Get token =======
    func webserviceGetToken(){
        
        if let reqModel = self.tokenRequestModel{

            UtilityClass.showHUD()
            WebServiceSubClass.Token(reqModel: reqModel) { (status, response, error) in
                UtilityClass.hideHUD()
                if status {
                    print(response!)
                }
                else {
                   if let homeVC = self.homeVC{
                     UtilityClass.showAlertOfAPIResponse(param: error, vc: homeVC)
                }
            }
        }
    
        }

    }
        
}

