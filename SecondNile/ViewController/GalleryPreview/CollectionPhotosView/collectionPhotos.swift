//
//  collectionPhotos.swift
//

import UIKit

class collectionPhotos: UICollectionViewCell {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imgPhotos: UIImageView!
//    var DeleteRecord : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnCancelTap(_ sender: Any) {
//        DeleteRecord!()
//        if let obj = DeleteRecord{
//        obj()
//    }
    }
    @objc func deleteClicked(){
        
    }
}
