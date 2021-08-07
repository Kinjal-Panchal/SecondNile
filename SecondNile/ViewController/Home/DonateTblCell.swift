//
//  DonateTblCell.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit
import WaveAnimationView


class DonateTblCell: UITableViewCell {

    //MARK:- ======= Outlets ======
    @IBOutlet weak var viewWaveAnimation: UIView!
    @IBOutlet weak var lblCampaignName: UILabel!
    @IBOutlet weak var lblTotalDonation: UILabel!
    @IBOutlet weak var lblRemainingDonation: UILabel!
    

   //MARK:- ==== Variables =====
    var wave: WaveAnimationView!
    var isStart = false
    var btnclickDonate :(()->())?
    var btnClickHistory :(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
         


    }
    
    @IBAction func btnActionDonateHistoryDetail(_ sender: UIButton) {
        
        if let clickedHistoryDetail = btnClickHistory {
            clickedHistoryDetail()
        }

        
    }
    
    @IBAction func btnActionDonate(_ sender: UIButton) {
        if let clickedDonate = btnclickDonate {
            clickedDonate()
        }
        
        
        
        
    }
    
    
    
    
    func DataSetup(objDetails:HomeDetails){
        let obj = objDetails.donation
        lblCampaignName.text = obj?.name
        let strRemaining =  UtilityClass.getDonationRemaining(Total: Double(obj?.amount ?? "0") ?? 0.0, Received: Double(obj?.receivedDonation ?? "0") ?? 0.0)
         lblRemainingDonation.text = "$\(strRemaining)"
        let percentage = UtilityClass.calculatePercentage(value: strRemaining, percentageVal: 1)
        if isStart == false {
            
            waveSetup(Progress: Float(percentage))
        }
        
    }
    
    func waveSetup(Progress:Float){
         isStart = true
        wave = WaveAnimationView(frame: CGRect(x: 0, y: 0, width: viewWaveAnimation.frame.width, height: viewWaveAnimation.frame.height), color: UIColor.blue.withAlphaComponent(0.5))


        if !viewWaveAnimation.subviews.contains(wave){
            viewWaveAnimation.addSubview(wave)
        }

        wave.startAnimation()
//        lapView.layer.anchorPoint = CGPoint.zero
//        lapView.transform = CGAffineTransform(rotationAngle: 90)
        viewWaveAnimation.transform = CGAffineTransform(rotationAngle: .pi/2)

        wave.backgroundColor = UIColor(red: 181/255, green: 238/255, blue: 251/255, alpha: 1.0)
        wave.frontColor = UIColor(red: 76/255, green: 124/255, blue: 205/255, alpha: 0.5)
        wave.backColor = UIColor(red: 76/255, green: 124/255, blue: 205/255, alpha: 0.5)
        viewWaveAnimation.layer.borderColor = colors.ThemeDarkBlue.value.cgColor
        wave.setProgress(Progress)


    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
