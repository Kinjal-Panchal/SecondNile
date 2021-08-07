//
//  HomeVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 21/07/21.
//

import UIKit
import WaveAnimationView
import FlexiblePageControl

class HomeVC: BaseVC , UIScrollViewDelegate{

    //MARK:- ==== Outlets =====
    @IBOutlet weak var lblCampaignName: UILabel!
    @IBOutlet weak var imgCampaign: UIImageView!
    @IBOutlet weak var lblAmmount: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTotalDonation: UILabel!
    @IBOutlet weak var lblRemainingDonation: UILabel!
    @IBOutlet weak var tblListOfNileInfo: UITableView!
    @IBOutlet weak var pageControll: FlexiblePageControl!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var viewWaveAnimation: UIView!
    @IBOutlet weak var collListPhotos: UICollectionView!
    @IBOutlet var colofButton: [UIButton]!
    
    @IBOutlet weak var lblOpenedWell: UILabel!
    
   //MARK:- ===== Variables ===
    var homeUserModel = HomeUserModel()
    var navBar: UINavigationBar = UINavigationBar()
    var wave: WaveAnimationView!
    var selectedTitle = String()
    var refreshControl = UIRefreshControl()
    var selectedTab  = Int()
//        didSet {
//         if selectedTab == 2 {
//            scrollview.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
//         }
//         else if selectedTab == 1 {
//            scrollview.setContentOffset(CGPoint(x:0 , y: 0), animated: true)
//           }
//        }
//      }

    
    //MARK :- ===== viewController life cycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeUserModel.homeVC = self
        self.homeUserModel.webserviceCallHomeScreen(showHud: true)
        refreshControl.addTarget(self, action:
                                    #selector(DataRefresh),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = colors.ThemeLightBlue.value
        tblListOfNileInfo.addSubview(refreshControl)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DataRefresh"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DataRefresh), name: NSNotification.Name(rawValue: "DataRefresh"), object: nil)
        self.navigationController?.navigationBar.isHidden = true
        let tabBar = self.tabBarController!.tabBar
       tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.hexStringToUIColor(hex: "#1646DB"), size: CGSize(width:50, height: tabBar.frame.height), lineHeight: 4.0)
        //tabBar.frame.width/CGFloat(tabBar.items!.count)

        self.collListPhotos.reloadData()
        
        SelectBtnSetup(btn: colofButton[1], isSelected: true)
        selectedTab = 1
        pageControlSetup()
        DataRefresh()
        

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

       // wave.stopAnimation()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true

         /// self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func DataRefresh(){
        self.homeUserModel.homeVC = self
        self.homeUserModel.webserviceCallHomeScreen(showHud: false)
    }
    
    


    @IBAction func btnActionDonateHistoryDetail(_ sender: UIButton) {

        let donatehistory = DonateGalleryVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(donatehistory, animated: true)
    }
    
    


//MARK:- ==== PageControl Setup ======
    func pageControlSetup(){

        pageControll.currentPageIndicatorTintColor = colors.ThemeDarkBlue.value
        pageControll.numberOfPages = 8
        let config = FlexiblePageControl.Config(
            dotSize: 8,
            dotSpace: 4,
            smallDotSizeRatio: 0.5,
            mediumDotSizeRatio: 0.7
        )
        pageControll.setConfig(config)
    }

    @IBAction func btnActionDonate(_ sender: UIButton) {

        let planVc : DonatePlanVC = DonatePlanVC.instantiate(appStoryboard: .main)
        planVc.donationDetail = homeUserModel.homeDetails?.donation
        planVc.navigateToPayment = { (currentplan, ammount , month , id) in
            let vc:DonatePaymentVC = DonatePaymentVC.instantiate(appStoryboard: .main)
            vc.donationReqModel.compaign_id = id;
            vc.donationReqModel.donation_month = month
            vc.donationReqModel.donation_amount = ammount
            vc.donationReqModel.donation_type = currentplan.lowercased()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.present(planVc, animated: true, completion: nil)
        
    }

    @IBAction func btnActionAboutUs(_ sender: UIButton) {

        let aboutUsVC = self.storyboard?.instantiateViewController(identifier: "AboutUsVC") as! AboutUsVC
        self.navigationController?.pushViewController(aboutUsVC, animated: true)
    }

    

    @IBAction func btnActionShowMore(_ sender: UIButton) {

        let donatersVC = self.storyboard?.instantiateViewController(identifier: "DonatorsVC") as! DonatorsVC
        if selectedTab == 1 , homeUserModel.homeDetails?.lastDonators?.count != 0 && (homeUserModel.homeDetails?.lastDonators!.count)! > 5{
            donatersVC.arrDonators = (homeUserModel.homeDetails?.lastDonators)!
        }
        else {
            if homeUserModel.homeDetails?.topDonators?.count != 0 && (homeUserModel.homeDetails?.topDonators!.count)! > 5{
                donatersVC.arrDonators = (homeUserModel.homeDetails?.topDonators)!
          }
        }
        
        self.navigationController?.pushViewController(donatersVC, animated: true)
    }
    
    @IBAction func btnActionTab(_ sender: UIButton) {

        if colofButton.contains(where: {$0.isSelected == true && selectedTitle == sender.currentTitle})  {
            return
        }
        else {
            colofButton.forEach { (btn) in
                    SelectBtnSetup(btn: btn, isSelected: false)
              }
                 sender.isSelected = true
                 selectedTab = sender.tag

              if sender.isSelected == true {
                  SelectBtnSetup(btn: sender, isSelected: true)
                  selectedTitle = sender.currentTitle ?? ""

              }
           }

       }
      //MARK:- ==== UnSelectedBtn =======
        func SelectBtnSetup(btn:UIButton, isSelected : Bool){
            btn.isSelected = isSelected
            btn.backgroundColor = isSelected == false ? UIColor.white : colors.ThemeDarkBlue.value
            btn.titleLabel?.font = CustomFont.MuseoSans_700.returnFont(FontSize.size16.rawValue)
            selectedTab = btn.tag
            btn.setTitleColor(isSelected == false ? colors.ThemeDarkBlue.value : UIColor.white, for: .normal)
         }




    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.setProgress(contentOffsetX: scrollView.contentOffset.x, pageWidth: scrollView.bounds.width)
    }



    func waveSetup(Progress:Float){

        wave = WaveAnimationView(frame: CGRect(x: 0, y: 0, width: viewWaveAnimation.frame.width, height: viewWaveAnimation.frame.height), color: UIColor.blue.withAlphaComponent(0.5))


        if !viewWaveAnimation.subviews.contains(wave){
            viewWaveAnimation.addSubview(wave)
        }

        wave.startAnimation()
//        lapView.layer.anchorPoint = CGPoint.zero
//        lapView.transform = CGAffineTransform(rotationAngle: 90)
        viewWaveAnimation.transform = CGAffineTransform(rotationAngle: .pi/2)

        wave.backgroundColor = UIColor(red: 181/255, green: 238/255, blue: 251/255, alpha: 1.0)
        wave.frontColor = UIColor(red: 76/255, green: 124/255, blue: 205/255, alpha: 0.5)
        wave.backColor = UIColor(red: 76/255, green: 124/255, blue: 205/255, alpha: 0.5)
        viewWaveAnimation.layer.borderColor = colors.ThemeDarkBlue.value.cgColor
        wave.setProgress(Progress)


    }

}
extension HomeVC : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photolistCollectionCell", for: indexPath) as! photolistCollectionCell
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collListPhotos.frame.width, height: self.collListPhotos.frame.height)
    }



}

extension HomeVC : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DonateTblCell", for: indexPath) as! DonateTblCell
            cell.btnClickHistory  = {
                let donatehistory = DonateGalleryVC.instantiate(appStoryboard: .main)
                self.navigationController?.pushViewController(donatehistory, animated: true)
            }
            
            cell.btnclickDonate = {
                let planVc : DonatePlanVC = DonatePlanVC.instantiate(appStoryboard: .main)
                planVc.donationDetail = self.homeUserModel.homeDetails?.donation
                planVc.navigateToPayment = { (currentplan, ammount , month , id) in
                    let vc:DonatePaymentVC = DonatePaymentVC.instantiate(appStoryboard: .main)
                    vc.donationReqModel.compaign_id = id;
                    vc.donationReqModel.donation_month = month
                    vc.donationReqModel.donation_amount = ammount
                    vc.donationReqModel.donation_type = currentplan.lowercased()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                self.present(planVc, animated: true, completion: nil)
            }
            if let obj = homeUserModel.homeDetails {
                cell.DataSetup(objDetails: obj)
            }
          
            return cell

        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTblCell", for: indexPath) as! AboutUsTblCell
            if let obj = homeUserModel.homeDetails {
                cell.DataSetup(objDetails: obj)
            }
            cell.btnClickAbout = {
                let aboutUsVC = self.storyboard?.instantiateViewController(identifier: "AboutUsVC") as! AboutUsVC
                self.navigationController?.pushViewController(aboutUsVC, animated: true)
            }
            return cell

        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoListTblCell", for: indexPath) as! PhotoListTblCell
            cell.colPhotos.reloadData()
            cell.selectedIndex = { (index , images) in
                let vc : PreviewGalaryVC = PreviewGalaryVC.instantiate(appStoryboard: .main)
                vc.firstTimeSelectedIndex = index
                vc.arrImage = images
                self.navigationController?.present(vc, animated: true)
                
            }
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DonatorListTblCell", for: indexPath) as! DonatorListTblCell
            
            cell.selectedTabGet = { (tabselected) in
                if tabselected == 1 {
                    if self.homeUserModel.homeDetails?.lastDonators?.count != 0 {
                        let arraySlice = self.homeUserModel.homeDetails?.lastDonators?.prefix(upTo: 5)
                        cell.arrLastdonators = Array(arraySlice!)
                       
                    }
                }
                else {
                    if self.homeUserModel.homeDetails?.topDonators?.count != 0 {
                        let arraySlice = self.homeUserModel.homeDetails?.topDonators?.prefix(upTo: 5)
                        cell.arrTopDonators = Array(arraySlice!)
                       
                    }
                }
                cell.collectionOfDonators.reloadData()
                
            }
            
            
            
            //cell.collectionOfDonators.reloadData()
            cell.btnClickMore = { (TabSelected) in
                let donatersVC = self.storyboard?.instantiateViewController(identifier: "DonatorsVC") as! DonatorsVC
                
                if TabSelected == 1 , self.homeUserModel.homeDetails?.lastDonators?.count != 0 && (self.homeUserModel.homeDetails?.lastDonators!.count)! > 5{
                    donatersVC.arrDonators = (self.homeUserModel.homeDetails?.lastDonators)!
                }
                else {
                    if self.homeUserModel.homeDetails?.topDonators?.count != 0 && (self.homeUserModel.homeDetails?.topDonators!.count)! > 5{
                        donatersVC.arrDonators = (self.homeUserModel.homeDetails?.topDonators)!
                  }
                }
                
                self.navigationController?.pushViewController(donatersVC, animated: true)
            }
            return cell

        default:
            break
        }
        return UITableViewCell()
    }
}
