//
//  DonateDetailVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit

class CampaginDetailVC: BaseVC {


    //MARK: --====== Outlets =======
    @IBOutlet weak var colOfGallery: UICollectionView!
    @IBOutlet weak var imgNile: UIImageView!

    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewStack: UIStackView!

    //MARK:- ===== Variables =====
    var isFromLocation = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
         UISetup(isHidden: isFromLocation)
        setNavBarWithMenuORBack(Title: "Detail", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: true)



    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isTranslucent = false
    }



    //MARK:- ===== UISetup =====
    func UISetup(isHidden : Bool) {
        lblStatus.isHidden =  !isHidden
        viewDate.isHidden = !isHidden
        viewStack.isHidden = isHidden
        imgNile.layoutIfNeeded()
        imgNile.roundCorners([.bottomLeft, .bottomRight], radius: 20)

        colOfGallery.reloadData()

    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }

}

extension CampaginDetailVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let gallerycell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonateGalleryCollectionViewCell", for: indexPath) as! DonateGalleryCollectionViewCell

            return gallerycell


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return  CGSize(width:120, height: colOfGallery.frame.height)

    }
}

