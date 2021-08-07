//
//  HomeResponseModel.swift
//  SecondNile
//
//  Created by panchal kinjal  on 01/08/21.
//

import Foundation


// MARK: - HomeResponseModel
// MARK: - HomeResponseModel
class HomeResponseModel: Codable {
    let message: String?
    let data: HomeDetails?
    let status: Int?

    init(message: String?, data: HomeDetails?, status: Int?) {
        self.message = message
        self.data = data
        self.status = status
    }
}

// MARK: - DataClass
class HomeDetails : Codable {
    let openedWell: Int?
    let donation: Donation?
    let photos: [String]?
    let lastDonators, topDonators: [Donator]?
    
    enum CodingKeys: String, CodingKey {
        case openedWell = "opened_well"
        case donation, photos
        case lastDonators = "last_donators"
        case topDonators = "top_donators"
    }
    
    init(openedWell: Int?, donation: Donation?, photos: [String]?, lastDonators: [Donator]?, topDonators: [Donator]?) {
        self.openedWell = openedWell
        self.donation = donation
        self.photos = photos
        self.lastDonators = lastDonators
        self.topDonators = topDonators
    }
}


// MARK: - Donation
class Donation: Codable {
    let id: Int
    let name, donationDescription, amount, location: String
    let image: String
    let fullImage: String
    let receivedDonation: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case donationDescription = "description"
        case amount, location, image
        case fullImage = "full_image"
        case receivedDonation = "received_donation"
    }

    init(id: Int, name: String, donationDescription: String, amount: String, location: String, image: String, fullImage: String, receivedDonation: String) {
        self.id = id
        self.name = name
        self.donationDescription = donationDescription
        self.amount = amount
        self.location = location
        self.image = image
        self.fullImage = fullImage
        self.receivedDonation = receivedDonation
    }
}

// MARK: - Donator
class Donator: Codable {
    let id: Int?
    let name: String?
    let nickName: String?
    let donationAmount: String?
    let createdAt: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nickName = "nick_name"
        case donationAmount = "donation_amount"
        case createdAt = "created_at"
    }

    init(id: Int?, name: String?, nickName: String?, donationAmount: String?, createdAt: Int?) {
        self.id = id
        self.name = name
        self.nickName = nickName
        self.donationAmount = donationAmount
        self.createdAt = createdAt
    }
}
