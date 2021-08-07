//
//  ProfileVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 18/07/21.
//

import UIKit

struct MenuList {
    var menutitle : String!
    var MenuIcon : String!
    var Status : Bool!
}

class MenuTblCell : UITableViewCell {

    //MARK:- ====== Outlets ========
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var lblmenuTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    //MARK:- ===== Variables =====
    var switchUpdate : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- ====== Switch action =====
    @IBAction func btnActionSwitch(_ sender: UISwitch) {
        
        if let bntnSwitchClicked = switchUpdate {
            bntnSwitchClicked()
        }
        
    }
}

class ProfileVC: UIViewController {
    
    //MARK:- ======= Outlets =======
    @IBOutlet weak var tblmenuList: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewStack: UIStackView!
    @IBOutlet weak var conHeightOfStack: NSLayoutConstraint!
    
    @IBOutlet weak var viewProfile: UIView!
    
    
    //MARK:- ===== Variables =====
    var profileUserModel = ProfileViewModel()
    var notificationStatus = Int()
    var arrMenuList = [MenuList]()
    
     
    //MARK:- ===== View controller LifeCycle ====
    override func viewDidLoad() {
        super.viewDidLoad()
        
         ProfileScreenUiSetup()
         addObserverTorefreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetup()
    }
    
    func ProfileScreenUiSetup(){
        if (UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil) == true {
            viewStack.isHidden = true
            conHeightOfStack.constant = 0
           // self.viewProfile.frame.size.height =  (self.viewProfile.frame.size.height - 70)
            arrMenuList = [
               MenuList(menutitle: "Edit Profile", MenuIcon: "ic_EditProfile", Status: false),
               MenuList(menutitle: "Push Notifications", MenuIcon: "ic_Notification", Status: true),
               MenuList(menutitle: "Change password", MenuIcon: "ic_Lock", Status: false),
               MenuList(menutitle: "Campaign History", MenuIcon: "ic_CampaginHistory", Status: false),
               MenuList(menutitle: "Payment Method", MenuIcon: "ic_Payment", Status: false),
               MenuList(menutitle: "Donation history", MenuIcon: "ic_Donation", Status: false),
               MenuList(menutitle: "About Us", MenuIcon: "ic_AboutUs", Status: false),
               MenuList(menutitle: "Help", MenuIcon: "ic_Help", Status: false),
               MenuList(menutitle: "Logout", MenuIcon: "ic_Logout", Status: false)]
              profileUserModel.profileVc = self
              profileUserModel.webserviceCallProfile()
        }
        else {
            viewStack.isHidden = false
            conHeightOfStack.constant = 45
            arrMenuList = [
              
               MenuList(menutitle: "About Us", MenuIcon: "ic_AboutUs", Status: false),
               MenuList(menutitle: "Help", MenuIcon: "ic_Help", Status: false)]
        }
    }
    
    //MARK :- ====== Btn Action Login =====
    @IBAction func btnActionLogin(_ sender: UIButton) {
        let loginvc : LoginVC = LoginVC.instantiate(appStoryboard: .Auth)
        loginvc.isFromProfile = true
        self.navigationController?.pushViewController(loginvc, animated: true)
        
    }
    
    //MARK:- ====== Btn Action Register =====
    @IBAction func btnActionRegister(_ sender: UIButton) {
        let registervc : RegisterVC = RegisterVC.instantiate(appStoryboard: .Auth)
        registervc.isFromProfile = true
        self.navigationController?.pushViewController(registervc, animated: true)
        
    }
    //MARK:- ===== Navigationbar Setup ======
    func navigationBarSetup(){
        self.navigationController?.navigationBar.isTranslucent = false
        setNavBarWithMenuORBack(Title: "Profile", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
    }
    
    //MARK: ===== Notification add observer ======
    func addObserverTorefreshData(){
        NotificationCenter.default.removeObserver(self, name: NotificationObeserverKeys.ProfiledataRefresh, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getProfileData), name: NotificationObeserverKeys.ProfiledataRefresh, object: nil)
    }
    
    @objc func getProfileData(){
        profileUserModel.profileVc = self
        profileUserModel.webserviceCallProfile()
    }
    
    func showAlert(BtnAction : @escaping ()->()){
        let alert = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            BtnAction()
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    

}

//MARK:- ====== TableView DataSource and Delegate Methods =====
extension ProfileVC : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTblCell", for: indexPath) as! MenuTblCell
        cell.lblmenuTitle.text = arrMenuList[indexPath.row].menutitle
        cell.btnSwitch.isHidden = !arrMenuList[indexPath.row].Status
        cell.btnSwitch.isOn = profileUserModel.profileData?.notificationStatus == 1 ? true : false
        cell.switchUpdate = {
            self.profileUserModel.notificationReqModel = NotificationRequestModel(status:cell.btnSwitch.isOn ? "1" : "0")
            self.profileUserModel.webserviceCallChangenotificationStatus()
        }
        cell.imgIcon.image = UIImage(named: arrMenuList[indexPath.row].MenuIcon)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch arrMenuList[indexPath.row].menutitle {
        case "Edit Profile":
            let editProfileVC:EditProfileVC = EditProfileVC.instantiate(appStoryboard: .main)
            editProfileVC.profileUserModel = profileUserModel
            self.navigationController?.pushViewController(editProfileVC, animated: true)

        case "Donation history" :
            let donationHistory = DonateHistoryVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(donationHistory, animated: true)

        case "Change password" :
            let changePasswordVC = ChangePasswordVC.instantiate(appStoryboard: .Auth)
            self.navigationController?.pushViewController(changePasswordVC, animated: true)

        case "Payment Method" :
            let paymentVC = PaymentVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(paymentVC, animated: true)

        case "Campaign History" :
            let campaginListVC = CampaginVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(campaginListVC, animated: true)

        case "About Us" :
            let aboutusVC = AboutUsVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(aboutusVC, animated: true)
            
        case "Logout":
            self.showAlert {
                self.profileUserModel.webServiceCallLogout()
            }

        default:
            break
        }
    }

}
