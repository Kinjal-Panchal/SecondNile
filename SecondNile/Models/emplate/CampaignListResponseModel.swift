//
//  CampaignListResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 03/08/21.
//

import Foundation

// MARK: - CampaignResponseModel
class CampaignResponseModel: Codable {
    let message: String?
    let data: CampaignData?
    let status: Int?

    init(message: String?, data: CampaignData?, status: Int?) {
        self.message = message
        self.data = data
        self.status = status
    }
}

// MARK: - DataClass
class CampaignData: Codable {
    let active: Compaign?
    let completed: [Compaign]?

    init(active: Compaign?, completed: [Compaign]?) {
        self.active = active
        self.completed = completed
    }
}

//// MARK: - Active
//class Active: Codable {
//    let id: Int?
//    let name, activeDescription, amount, location: String?
//    let image: String?
//    let fullImage: String?
//    let receivedDonation: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case activeDescription = "description"
//        case amount, location, image
//        case fullImage = "full_image"
//        case receivedDonation = "received_donation"
//    }
//
//    init(id: Int?, name: String?, activeDescription: String?, amount: String?, location: String?, image: String?, fullImage: String?, receivedDonation: String?) {
//        self.id = id
//        self.name = name
//        self.activeDescription = activeDescription
//        self.amount = amount
//        self.location = location
//        self.image = image
//        self.fullImage = fullImage
//        self.receivedDonation = receivedDonation
//    }
//}
