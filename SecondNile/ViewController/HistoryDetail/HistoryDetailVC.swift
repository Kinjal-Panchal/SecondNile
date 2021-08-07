//
//  HistoryDetailVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 24/07/21.
//

import UIKit

class TrackStatus {
    var icon : String!
    var status : String!

    init(Icon:String,Status:String) {
        self.icon = Icon
        self.status = Status
    }
}


class DonationTrackingCell : UICollectionViewCell {

    
    //MARK:- ====== Outlets =======
    @IBOutlet weak var viewTrackTop: UIView!
    @IBOutlet weak var lblTrackStatus: UILabel!
    @IBOutlet weak var viewTrackLine: UIView!
    @IBOutlet weak var imgTrackStatus: UIImageView!
}



class HistoryDetailVC: BaseVC {

   //MARK:- ====== Outlets =======
    @IBOutlet weak var collectionOfTracking: UICollectionView!
    @IBOutlet weak var imgNile: UIImageView!

    
    //MARK:-= ====== Variables ======
    var arrTrackStatus = [TrackStatus]()
    
    //MARK:- ====== View Controller Life Cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()

        arrTrackStatus = [TrackStatus(Icon: "ic_BSuccess", Status: "Payment Successfully"),
                          TrackStatus(Icon: "ic_BReceived", Status: "Payment Received"),
                          TrackStatus(Icon: "ic_GComplete", Status: "Compaign Complete"),
                          TrackStatus(Icon: "ic_GConstruction", Status: "Under Construction"),
                          TrackStatus(Icon: "ic_GFinish", Status: "Finish")]


     imgNile.layoutIfNeeded()
     imgNile.roundCorners([.bottomLeft, .bottomRight], radius: 20)
     setNavBarWithMenuORBack(Title: "Detail", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: true)
     collectionOfTracking.reloadData()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isTranslucent = false
    }
}

//MARK:- Collectionview DataSource and delegate
extension HistoryDetailVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrTrackStatus.count

}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationTrackingCell", for: indexPath) as! DonationTrackingCell

    cell.lblTrackStatus.text = arrTrackStatus[indexPath.row].status
    cell.imgTrackStatus.image = UIImage(named: arrTrackStatus[indexPath.row].icon)
    cell.viewTrackLine.isHidden = indexPath.row == arrTrackStatus.count - 1 ? true : false
    if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 {
        cell.viewTrackLine.backgroundColor = UIColor.hexStringToUIColor(hex: "#8D9ABA")
            
            //UIColor(red: 155/255, green: 165/255, blue: 192/255, alpha: 1.0)
        cell.viewTrackTop.backgroundColor = UIColor.hexStringToUIColor(hex: "#8D9ABA")
            //UIColor(red: 155/255, green: 165/255, blue: 192/255, alpha: 1.0)
    }
      return cell
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return  CGSize(width:75, height: collectionOfTracking.frame.height)

}
}



