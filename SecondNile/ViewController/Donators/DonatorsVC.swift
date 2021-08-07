//
//  DonatorsVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 17/07/21.
//

import UIKit

//MARK :- ===== Donator TableView Cell =======
class DonatorTblCell : UITableViewCell {

 //MARK: - ===== Outlets ======
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAmmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

class DonatorsVC: BaseVC {

    //MARK:- ===== Outlets ======
    @IBOutlet weak var tblDaonatorsList: UITableView!

     //MARK:- ===== Variables ========
    var arrDonators  = [Donator]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationBarSetup()
        self.tblDaonatorsList.reloadData()

    }
    
    

    //MARK:- ====== NavigationBar Setup ====
    func navigationBarSetup(){
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithMenuORBack(Title: "Donators", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
    }
}

//MARK:- ====== Tableview DataSource and  Delegate Methods =====
extension DonatorsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDonators.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"DonatorTblCell" , for: indexPath) as! DonatorTblCell
        let objIndex = arrDonators[indexPath.row]
        cell.lblName.text = "\(indexPath.row + 1). \(objIndex.name ?? "")"
        cell.lblAmmount.text = "$\(objIndex.donationAmount ?? "")"
        let strtime = Double(objIndex.createdAt ?? 00)
        cell.lblDate.text = strtime.getDateStringFromUTC()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
}
