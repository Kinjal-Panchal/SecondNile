//
//  DonationListResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 02/08/21.
//

import Foundation

// MARK: - DonateResponseModel
class DonateResponseModel: Codable {
    let message: String?
    let data: DonationData?
    let status: Int?
    
    init(message: String?, data: DonationData?, status: Int?) {
        self.message = message
        self.data = data
        self.status = status
    }
    
}

// MARK: - DataClass
class DonationData: Codable {
    
    let compaign: Compaign?
    let galley: [String]?
    
    enum CodingKeys: String, CodingKey {
                   case compaign = "compaign"
                   case galley = "galley"
           }
    
    init(compaign: Compaign?, galley: [String]?) {
        self.compaign = compaign
        self.galley = galley
    }
    
    
    
}

// MARK: - Compaign
class Compaign: Codable {
    let id: Int?
    let name, compaignDescription, amount, location: String?
    let image: String?
    let fullImage: String?
    let receivedDonation: String?
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case compaignDescription = "description"
            case amount = "amount"
            case location = "location"
            case image = "image"
            case fullImage = "full_image"
            case receivedDonation = "received_donation"
        }
    
    init(id: Int?, name: String?, compaignDescription: String?, amount: String?, location: String?, image: String?, fullImage: String?, receivedDonation: String?) {
        self.id = id
        self.name = name
        self.compaignDescription = compaignDescription
        self.amount = amount
        self.location = location
        self.image = image
        self.fullImage = fullImage
        self.receivedDonation = receivedDonation
    }
    
    
}
