//
//  DonationRequestResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 03/08/21.
//

import Foundation

//MARK: - Donation Request model
class DonationRequestModel : Encodable{
    var donation_type: String?
    var donation_amount : String?
    var donation_month: String?
    var billing_address_1: String?
    var billing_address_2 : String?
    var country : String?
    var state : String?
    var zipcode : String?
    
    var phone : String?
    var compaign_id : String?
    
    
//    init(donation_type: String?,donation_amount: String?,donation_month: String?,billing_address_1: String?,country: String?,billing_address_2: String?,state: String?,zipcode: String?,phone: String?,compaign_id: String?) {
//    
//        self.donation_type = donation_type
//        self.donation_amount = donation_amount
//        self.donation_month = donation_month
//        self.billing_address_1 = billing_address_1
//        self.billing_address_2 = billing_address_2
//        self.country = country
//        self.zipcode = zipcode
//        self.phone = phone
//        self.compaign_id = compaign_id
//        self.state = state
//    }
    enum CodingKeys: String, CodingKey {
        case donation_type = "donation_type"
        case donation_amount = "donation_amount"
        case donation_month = "donation_month"
        case billing_address_1 = "billing_address_1"
        case billing_address_2 = "billing_address_2"
        case country = "country"
        case zipcode = "zipcode"
        case phone = "phone"
        case compaign_id = "compaign_id"
        case state = "state"
        
    }
}

