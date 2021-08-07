//
//  GalleryVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 20/07/21.
//

import UIKit

class GalleryVC: UIViewController ,UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{

   //MARK:- ======= Outlets =======
    @IBOutlet weak var collectionOfVideo: UICollectionView!

    @IBOutlet weak var collectionOfImages: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBarWithMenuORBack(Title: "Gallery", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
        collectionOfVideo.reloadData()
        collectionOfImages.reloadData()
    }





    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == collectionOfImages ? 10 : 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionOfImages {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoImgCollectionViewCell", for: indexPath) as! VideoImgCollectionViewCell

            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoImgCollectionViewCell", for: indexPath) as! VideoImgCollectionViewCell

            return cell
        }

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == collectionOfVideo {
            let h = 220//collectionView.frame.size.height / 2.5
            let w = collectionView.frame.width / 2 - 5
            return  CGSize(width: CGFloat(w), height: CGFloat(h))
        }
        else {
            let h = 220//collectionView.frame.size.height / 2.5
            let w = collectionView.frame.width / 2 - 5
            return  CGSize(width: CGFloat(w), height: CGFloat(h))
        }


        
    }
}



