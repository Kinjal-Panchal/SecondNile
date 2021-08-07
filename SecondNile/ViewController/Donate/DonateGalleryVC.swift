//
//  DonateGalleryVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit

class DonateGalleryVC: BaseVC {

  //MARK: --====== Outlets =======

    @IBOutlet weak var colOfDonateInfo: UICollectionView!
    @IBOutlet weak var colOfGallery: UICollectionView!


    //MARK:- ===== Variables =====
    var donationViewModel = DonationListViewModel()

//MARK:- ====== View Controller Life Cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithMenuORBack(Title: "Donate", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
        colOfGallery.reloadData()
        donationViewModel.DonationPageVc = self
        donationViewModel.webserviceCallDonatePage()

    }


    //MARK:- ====== Btn Action See All ====
    @IBAction func btnActionSeeAll(_ sender: UIButton) {
        let galleryVc = GalleryVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(galleryVc, animated: true)

    }

}

extension DonateGalleryVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == colOfDonateInfo ? 1 : 6
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colOfDonateInfo {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonateInfoCollectionCell", for: indexPath) as! DonateInfoCollectionCell
            if let obj = donationViewModel.donationdataResponse?.compaign {
                cell.compaigndataSetup(objCampaign:obj)
            }
            return cell
        }
        else {
            let gallerycell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonateGalleryCollectionViewCell", for: indexPath) as! DonateGalleryCollectionViewCell
            gallerycell.viewPlay.isHidden = indexPath.row % 2 == 0 ? false : true
            if indexPath.row % 2 != 0 {

                gallerycell.imgNile.image = UIImage(named: "african-kids-6UCY9BJ-1")
            }
            return gallerycell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return collectionView == colOfDonateInfo ? CGSize(width: colOfDonateInfo.frame.width, height: 250) : CGSize(width: colOfGallery.frame.width / 2 - 5, height: 145)

    }
}
