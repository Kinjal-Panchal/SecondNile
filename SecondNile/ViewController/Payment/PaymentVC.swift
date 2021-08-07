//
//  PaymentVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 18/07/21.
//

import UIKit

class PaymentVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetup()
    }
    

    //MARK:==== Navigationbar Setup ======
    func navigationBarSetup(){
        setNavBarWithMenuORBack(Title: "Payment Method", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
    }
}
