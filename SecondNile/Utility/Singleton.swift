//
//  Singleton.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 30/03/21.
//

import Foundation
import CoreLocation

class Singleton: NSObject
{
    
    static let shared = Singleton()
    
   var userProfileData : RegisterData?
    var UserId : String = ""
    var Api_Key = String()
    var DeviceToken : String = ""
    var userCurrentLocation = CLLocationCoordinate2D()
    var CurrentAddressString : String = ""
    var countryList = [CountryDetailModel]()
    
    func getUserName() -> (fullName : String , firstName :String , lastName : String ){
        if let first = Singleton.shared.userProfileData?.firstName , let last = Singleton.shared.userProfileData?.lastName {
            return ("\(first) \(last)",first , last)
        }
        return ("nil","nil","nil")
    }
    
    func getWalletBalance() -> (fullString : String , onlyBal : Double?){
        if let doubleVal = Double(Singleton.shared.userProfileData?.walletBalance ?? "") ,let balance = Singleton.shared.userProfileData?.walletBalance {
            return (("Wallet Balance: " + currency + balance), doubleVal )
        }
        return (("Wallet balance: \(currency)0.0"), nil )
    }
    
    var arrFutureYears:[String] {
        get {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return (currentYear...(currentYear + 11)).map { String($0)}
        }
    }
    
    func clearSingletonClass() {
        Singleton.shared.UserId = ""
        Singleton.shared.Api_Key = ""
        Singleton.shared.userProfileData = nil
    }
}

