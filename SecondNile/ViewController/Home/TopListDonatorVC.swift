//
//  TopListDonatorVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 22/07/21.
//

import UIKit

class TopListDonatorVC: UIViewController {


    @IBOutlet weak var collectionofDonators: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionofDonators.reloadData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TopListDonatorVC : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonatorListCollectionCell", for: indexPath) as! DonatorListCollectionCell
        
        
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionofDonators.frame.width / 2, height: 50)
    }

}
