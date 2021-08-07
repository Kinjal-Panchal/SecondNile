//
//  DonatorListTblCell.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit

class DonatorListTblCell: UITableViewCell {

    
    //MARK:- ===== Outlets =======
    @IBOutlet weak var collectionOfDonators: UICollectionView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var lbl2Date: ThemeBlackLabl500!
    @IBOutlet weak var lbl2ammount: ThemeBlackLabl500!
    @IBOutlet weak var lbl2Name: UILabel!
    @IBOutlet weak var lblDate1: UILabel!
    @IBOutlet weak var lbl1Ammount: UILabel!
    @IBOutlet weak var lbl1Name: UILabel!
    @IBOutlet var colOfButton: [UIButton]!
    
    
    //MARK: - ==== Variables =====
    var selectedTitle = String()
    var btnClickMore : ((Int)->())?
    var selectedTabGet: ((Int)->())?
    var tabselected : Int = 1
    var homeDetails : HomeDetails?
    var arrLastdonators = [Donator]()
    var arrTopDonators = [Donator]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionOfDonators.dataSource = self
        collectionOfDonators.delegate = self
        colOfButton[0].isSelected = true
        tabselected =  colOfButton[0].tag
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnActionShowMore(_ sender: UIButton) {
        if let btnClickedShowMore = btnClickMore {
            btnClickedShowMore(tabselected)
        }
       
    }
    
    @IBAction func btnActionTab(_ sender: UIButton) {
        
        if colOfButton.contains(where: {$0.isSelected == true && selectedTitle == sender.currentTitle})  {
            return
        }
        else {
            colOfButton.forEach { (btn) in
                    SelectBtnSetup(btn: btn, isSelected: false)
              }
                 sender.isSelected = true
                 tabselected = sender.tag

              if sender.isSelected == true {
                  SelectBtnSetup(btn: sender, isSelected: true)
                  selectedTitle = sender.currentTitle ?? ""
                if let selected = selectedTabGet {
                    selected(tabselected)
                }
              }
           }

       }
      //MARK:- ==== UnSelectedBtn =======
        func SelectBtnSetup(btn:UIButton, isSelected : Bool){
            btn.isSelected = isSelected
            btn.backgroundColor = isSelected == false ? UIColor.white : colors.ThemeDarkBlue.value
            btn.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
            tabselected = btn.tag
            btn.setTitleColor(isSelected == false ? colors.ThemeDarkBlue.value : UIColor.white, for: .normal)
         }



    

}
extension DonatorListTblCell : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabselected == 1 ? arrLastdonators.count : arrTopDonators.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonatorListCollectionCell", for: indexPath) as! DonatorListCollectionCell
        let objIndex = tabselected == 1 ? arrLastdonators[indexPath.row] : arrTopDonators[indexPath.row]
        
        cell.lblName.text = "\(indexPath.row + 1). \(objIndex.name ?? "")"
        cell.lblAmmount.text = "$\(objIndex.donationAmount ?? "")"
        let strtime = Double(objIndex.createdAt ?? 00)
        cell.lblDate.text = strtime.getDateStringFromUTC()
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionOfDonators.frame.width / 2, height: 70)
    }

}
