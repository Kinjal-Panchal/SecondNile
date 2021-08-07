//
//  DonateInfoCollectionCell.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit

class DonateInfoCollectionCell: UICollectionViewCell {
    
    //MARK:====== Outlets ======
    @IBOutlet weak var imgCampaign: UIImageView!
    @IBOutlet weak var viewDonateProgress: ProgressBarView!
    @IBOutlet weak var lblDonationPercentage: UILabel!
    @IBOutlet weak var lblDonation: UILabel!
    @IBOutlet weak var lblCampaignName: UILabel!
    
    
    //MARK:====== Variables ======
    var objCampaign : Compaign?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func compaigndataSetup(objCampaign:Compaign){
        lblDonation.text = "$\(objCampaign.amount ?? "")"
        lblCampaignName.text = objCampaign.name
        let strRemaining =  UtilityClass.getDonationRemaining(Total: Double(objCampaign.amount ?? "0") ?? 0.0, Received: Double(objCampaign.receivedDonation ?? "0") ?? 0.0)
        let percentage = UtilityClass.calculatePercentage(value: strRemaining, percentageVal: 1)
        lblDonationPercentage.text = "\(percentage)%"
        viewDonateProgress.setProgress(Float(percentage), animated: true)
        UtilityClass.imageGet(url: objCampaign.fullImage ?? "", img: imgCampaign)
    }
    @IBAction func btnActionDonate(_ sender: UIButton) {
    }
    
    
    @IBAction func btnActionViewAll(_ sender: UIButton) {
    }
    
    
}
