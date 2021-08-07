//
//  CampaginVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 18/07/21.
//

import UIKit


class CampaginTblCell : UITableViewCell {

    //MARK:- ===== Outlets =======
    @IBOutlet weak var imgCampagin: UIImageView!
    @IBOutlet weak var btnDonateStatus: UIButton!
    @IBOutlet weak var lblWaterLevel: UILabel!
    @IBOutlet weak var lblAmmount: UILabel!
    @IBOutlet weak var lblNile: UILabel!
    @IBOutlet weak var viewAmmount: UIView!
    @IBOutlet weak var viewLevel: UIView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var viewProgress: ProgressBarView!
    
    
    func CampaignDataSetup(obj:Compaign){
        lblNile.text = obj.name
        lblAmmount.text = "$ \(obj.amount ?? "")"
        UtilityClass.imageGet(url: obj.fullImage ?? "", img: imgCampagin)
        let strRemaining =  UtilityClass.getDonationRemaining(Total: Double(obj.amount ?? "0") ?? 0.0, Received: Double(obj.receivedDonation ?? "0") ?? 0.0)
        let percentage = UtilityClass.calculatePercentage(value: strRemaining, percentageVal: 1)
        lblWaterLevel.text = "\(percentage)%"
        viewProgress.setProgress(Float(percentage), animated: true)
    }
    

}

class CampaginVC: BaseVC {
    
    //MARK:====== Variables ======
    var campaignViewModel = CampaignViewModel()

    //MARK:- ====== Outlets =======
    @IBOutlet weak var tblCampagin: UITableView!


     //MARK:- ===== View Controller Life cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        campaignViewModel.campaignListVc = self
        campaignViewModel.webserviceCallCampaignList()
        // Do any additional setup after loading the view.
    }

    //MARK:- ====== Set navigationBar ====
    func setNavigationBar(){
        setNavBarWithMenuORBack(Title: "Campaign", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
    }


}

//MARK :- ====== TableView DataSource and Delegate =======
extension CampaginVC : UITableViewDataSource , UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        case 1:
            return campaignViewModel.arrCompleted.count
        default:
            break
        }
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CampaginTblCell", for: indexPath) as! CampaginTblCell
            cell.viewAmmount.isHidden = false
            cell.viewLevel.isHidden = false
            cell.viewStatus.isHidden = true
            if let obj = campaignViewModel.currentCampaign {
                cell.CampaignDataSetup(obj: obj)
            }
            
            return cell

        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "CampaginTblCell", for: indexPath) as! CampaginTblCell
            cell.viewAmmount.isHidden = true
            cell.viewLevel.isHidden = true
            cell.viewStatus.isHidden = false
            if campaignViewModel.arrCompleted.count != 0 {
                    cell.CampaignDataSetup(obj:campaignViewModel.arrCompleted[indexPath.row] )
                }
            
            
            return cell
        default:
            break
        }
        return UITableViewCell()

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
                let label = UILabel()
                label.frame = CGRect.init(x: 26, y: 5, width: headerView.frame.width , height: headerView.frame.height)
               headerView.backgroundColor = colors.ThemeBGColour.value
                 label.text = section == 0 ? "Ongoing" : "Completed"
                label.font = CustomFont.MuseoSans_500.returnFont(FontSize.size20.rawValue)

                 label.textColor = section == 0 ? UIColor.hexStringToUIColor(hex: "#1C9BFB") : UIColor.black

                headerView.addSubview(label)

                return headerView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let campaginDetailVc = CampaginDetailVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(campaginDetailVc, animated: true)
    }



}
