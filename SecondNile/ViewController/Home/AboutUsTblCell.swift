//
//  AboutUsTblCell.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit

class AboutUsTblCell: UITableViewCell {

    //MARK:- ==== Outlets =====
    @IBOutlet weak var imgCampaign: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK:- ==== Variables ====
    var btnClickAbout:(()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func DataSetup(objDetails:HomeDetails){
        let obj = objDetails.donation
        lblDescription.text = obj?.donationDescription
        UtilityClass.imageGet(url: obj?.fullImage ?? "" , img: (imgCampaign)!)
    }
    
    
    @IBAction func btnActionAboutUs(_ sender: UIButton) {
        if let aboutClicked = btnClickAbout{
            aboutClicked()
        }
         
       
    }
    
   


}
