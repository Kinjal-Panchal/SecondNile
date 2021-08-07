//
//  PhotoListTblCell.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit
import FlexiblePageControl


class photolistCollectionCell : UICollectionViewCell {


    @IBOutlet weak var imgCampaign: UIImageView!
}

class PhotoListTblCell: UITableViewCell , UIScrollViewDelegate{

    @IBOutlet weak var colPhotos: UICollectionView!
    @IBOutlet weak var pageControll: FlexiblePageControl!

    var selectedIndex : ((Int,[String])->())?
    var arrImages = ["african-kids-6UCY9BJ","african-kids-6UCY9BJ","african-kids-6UCY9BJ","african-kids-6UCY9BJ","african-kids-6UCY9BJ","african-kids-6UCY9BJ"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colPhotos.dataSource = self
        colPhotos.delegate = self
        pageControlSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- ==== PageControl Setup ======
        func pageControlSetup(){

            pageControll.currentPageIndicatorTintColor = colors.ThemeDarkBlue.value
            pageControll.numberOfPages = arrImages.count
            let config = FlexiblePageControl.Config(
                dotSize: 8,
                dotSpace: 4,
                smallDotSizeRatio: 0.5,
                mediumDotSizeRatio: 0.7
            )
            pageControll.setConfig(config)
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.setProgress(contentOffsetX: scrollView.contentOffset.x, pageWidth: scrollView.bounds.width)
    }


}

extension PhotoListTblCell : UICollectionViewDataSource,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photolistCollectionCell", for: indexPath) as! photolistCollectionCell
        cell.imgCampaign.image = UIImage(named: arrImages[indexPath.row])
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.colPhotos.frame.width, height: self.colPhotos.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectectIndex = selectedIndex{
            selectectIndex(indexPath.row, arrImages)
        }
       
    }
}
