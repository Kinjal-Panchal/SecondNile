//
//  SuccessPopupVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 24/07/21.
//

import UIKit

class SuccessPopupVC: UIViewController {

   
    var navToDashboard : (()->())?
    var donationviewModel = DonationViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
        donationviewModel.donationVC = self
        donationviewModel.webserviceCallDonation()
        
        self.navigationController?.navigationBar.isHidden = true
    }


    //MARK:- ====== Btn Action Dashboard ===
    @IBAction func btnActionDashBoard(_ sender: UIButton) {

        self.dismiss(animated: true) {
            if let dashboardClick = self.navToDashboard {
                dashboardClick()
            }
        }


    }



}
