//
//  DonateHistoryVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 18/07/21.
//

import UIKit

class DonationHistoryTblCell : UITableViewCell {

    //MARK:- ===== Outlets  ========
    @IBOutlet weak var imgDonation: UIImageView!
    @IBOutlet weak var lblDonationTime: UILabel!
    @IBOutlet weak var lblDonationTitle: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()

    }
}

//MARK:- ====== Donation Histoty  =====
class DonateHistoryVC: BaseVC {

    //MARK:- ====== Outlets ========
    @IBOutlet weak var tblDonationhistory: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
    }


    //MARK:==== Navigationbar Setup ======
    func navigationBarSetup(){
        setNavBarWithMenuORBack(Title: "Donate history", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
    }



}

//MARK:- ======= TableView DataSource and delegate Methods
extension DonateHistoryVC : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationHistoryTblCell", for: indexPath) as! DonationHistoryTblCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HistoryDetailVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
