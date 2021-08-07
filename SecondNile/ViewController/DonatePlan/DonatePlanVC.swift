//
//  DonatePlanVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 19/07/21.
//

import UIKit

enum selctedPlan : String{
    case monthly = "Montly"
    case once = "Once"
}
struct AmmountModel {
    var ammount : String!
    var monthly : String!
}

class DonatePlanTblCell : UITableViewCell {

     //MARK:- ====== Outlets ======
     @IBOutlet weak var lblDonateAmmount: UILabel!
     @IBOutlet weak var viewBG: UIView!
     @IBOutlet weak var ViewInner: UIView!

}

class DonatePlanVC: UIViewController {

    //MARK: -- ====== Outlets =======
    @IBOutlet weak var tblDonatePlans: UITableView!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet var btnCollection: [ThemeBlueButton]!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtMonthly: UITextField!
    @IBOutlet weak var viewMonthly: UIView!
    
    
    //MARK :- ====== Variables =====
    var arrDonationPlans = [AmmountModel(ammount: "50", monthly: "12"),
                    AmmountModel(ammount: "100", monthly: "6"),
                    AmmountModel(ammount: "150", monthly: "6"),
                    AmmountModel(ammount: "200", monthly: "3")]
    var arrcustomDonationPlan = [AmmountModel(ammount: "", monthly: "6"),
                              AmmountModel(ammount: "", monthly: "3")]
    var navigateToPayment : ((_ donationPlan:String,_ donationAmmount: String, _ month :String , _ id:String)->())?
    var selectedIndex = NSNotFound
    var strselectedPlan : selctedPlan = .once {
        didSet {
            txtPrice.text = ""
            selectedAmmount = ""
            selectedMonth = ""
            txtMonthly.text = ""
            viewMonthly.isHidden = strselectedPlan == .once ? true : false
            selectedIndex = NSNotFound
            tblDonatePlans.reloadData()
        }
    }
    var selectedMonth = String()
    var selectedAmmount = String()
    var donationDetail : Donation!
    var pickerView = UIPickerView()

    
    
    //MARK:- ===== ViewController Life Cycle ======
    override func viewDidLoad() {
        super.viewDidLoad()
        
            UIsetup()
    }
    
    func UIsetup(){
        txtMonthly.withImage(direction: .Right, image: UIImage(named: "ic_DownArrow")!, colorSeparator: .clear, colorBorder: .clear)
        pickerView.dataSource = self
        pickerView.delegate = self
        txtMonthly.inputView = pickerView
        txtMonthly.delegate = self
        txtPrice.delegate = self
        btnCollection[0].isSelected = true
        strselectedPlan = .once
        //btnMonth.addRightIcon(image: UIImage(named: "ic_DownArrow") ?? UIImage())
    }


    @IBAction func btnActionGiveMonthly(_ sender: UIButton) {
      
        for btn in btnCollection {
            btn.isSelected = false
        }
        sender.isSelected = true
        strselectedPlan = .monthly

    }

    @IBAction func btnActionOnce(_ sender: UIButton) {
        for btn in btnCollection {
            btn.isSelected = false
        }
        sender.isSelected = true
        strselectedPlan = .once
        
    }

    //MARK:- ===== Btn Action Price Manually =======
    @IBAction func btnActionEnterPriceManually(_ sender: UIButton) {

    }


 //MARK:- ====== Btn Action Monthly ======
    @IBAction func btnActionMonthly(_ sender: UIButton) {
    }


    //MARK:- ====== Btn Action Cancel ======
    @IBAction func btnActionCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


    //MARK:- ====== Btn Action Continue ======
    @IBAction func btnActionContinue(_ sender: UIButton) {
        let isvalidator = validation()
        if isvalidator.1 == false{
           AlertMessage.showMessageForError(isvalidator.0)
       }
        else  {
            self.dismiss(animated: true) {
                if let navToPayment = self.navigateToPayment {
                    navToPayment(self.strselectedPlan.rawValue , self.selectedAmmount , self.selectedMonth ,"\(self.donationDetail.id)")
                    print(self.selectedAmmount)
                    print(self.selectedMonth)
                    print(self.strselectedPlan.rawValue)
                }
             }
        }
    }
    
    //MARK:- ====== Validation ======
    func validation()->(String,Bool){
        var isValid = true
        var msg = ""
        if strselectedPlan.rawValue == "" {
            msg = "Please select donation plan"
        }
        else if selectedAmmount.isEmptyOrWhitespace(){
          msg = "Please select or enter ammount"
        }
        else if selectedMonth.isEmptyOrWhitespace() && strselectedPlan == .monthly {
               msg = "Please select month"
           }
         else if !(txtPrice.text?.isEmptyOrWhitespace())!{
           let value = CheckPrice(DonationAmmount: txtPrice.text ?? "0")
           if value.0 == false {
               msg = "Now organization will required only $\(value.1)"
           }
        }
         
        
        isValid = msg == "" ? true : false
        return(msg,isValid )
    }
    
    func CheckPrice(DonationAmmount : String) -> (Bool,Int) {
         let ammount = Int(DonationAmmount) ?? 0
        let total = Int(donationDetail.amount) ?? 0
        let received = Int(donationDetail.receivedDonation) ?? 0
        let difference : Int = total - received
        if ammount >= difference {
            return (false , difference)
        }
        return (true , 0)
    }
}

//MARK:- ====== TableView DataSource and Delegate Methods =====
extension DonatePlanVC : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDonationPlans.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonatePlanTblCell", for: indexPath) as! DonatePlanTblCell

        cell.viewBG.backgroundColor = selectedIndex == indexPath.row ? UIColor.hexStringToUIColor(hex: "#2AAEFC") : UIColor.hexStringToUIColor(hex: "#F2F2F2")

        cell.ViewInner.backgroundColor = selectedIndex == indexPath.row ? UIColor(red: 229/255, green: 243/255, blue: 252/255, alpha: 1) : UIColor.hexStringToUIColor(hex: "#FFFFFF")
        cell.ViewInner.isOpaque = false

        cell.lblDonateAmmount.textColor = selectedIndex == indexPath.row ? UIColor.hexStringToUIColor(hex: "#2AAEFC") : UIColor.hexStringToUIColor(hex: "#646464")

        cell.lblDonateAmmount.text =  strselectedPlan == .once ? "$\(arrDonationPlans[indexPath.row].ammount ?? "")"   : "$\(arrDonationPlans[indexPath.row].ammount ?? "")/\(arrDonationPlans[indexPath.row].monthly ?? "")Months"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selectedMonth = arrDonationPlans[selectedIndex].monthly
        selectedAmmount = arrDonationPlans[selectedIndex].ammount
        self.tblDonatePlans.reloadData()
    }


}

extension DonatePlanVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPrice || textField == txtMonthly{
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtPrice , txtPrice.text != ""{
            let index = IndexPath(row: selectedIndex, section: 0)
            selectedIndex = NSNotFound
            selectedMonth = selectedMonth != "" ? "" : selectedMonth
            selectedAmmount = ""
            tblDonatePlans.reloadRows(at: [index], with: .automatic)
            selectedAmmount = txtPrice.text ?? ""
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMonthly {
            return false
        }
        return true
    }
}

extension DonatePlanVC : UIPickerViewDataSource , UIPickerViewDelegate{
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           
              return  arrcustomDonationPlan.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
                 if txtMonthly.text == "" {
                    txtMonthly.text = "\(arrcustomDonationPlan[row].monthly ?? "") Month"
                    selectedMonth = arrcustomDonationPlan[row].monthly
                    return "\(arrcustomDonationPlan[row].monthly ?? "") Month"
                     
                 }
                 return "\(arrcustomDonationPlan[row].monthly ?? "") Month"
              }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
              txtMonthly.text = "\(arrcustomDonationPlan[row].monthly ?? "") Month"
              selectedMonth = arrcustomDonationPlan[row].monthly
           }
              
    }
