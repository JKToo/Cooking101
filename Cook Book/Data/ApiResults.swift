//
//  ApiResults.swift
//  Cook Book
//
//  Created by Justin on 3/31/22.
//


import Foundation

struct ResultData : Codable {
    var results: [Result]
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Result: Codable {
    let title: String?
    let minutes: Int
    let thumbnail: String
    let sourceURL: String
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case minutes = "readyInMinutes"
        case thumbnail = "image"
        case sourceURL = "sourceUrl"
    }
}

struct WineData: Codable{
    var wineProduct: [WineProducts]
    let pairing: String
    enum CodingKeys: String, CodingKey {
        case wineProduct = "productMatches"
        case pairing = "pairingText"
    }
}

struct WineProducts: Codable{
    let title: String?
    let description: String
    let price: String
    let thumbnail: String
    let link: String
    let rating: Double
    let ratingCount: Int
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case price = "price"
        case thumbnail = "imageUrl"
        case link = "link"
        case rating = "averageRating"
        case ratingCount = "ratingCount"
    }
}

struct AboutWine: Codable{
    var wineDetail: [WineDescription]
}

struct WineDescription: Codable{
    let pairing: String
    enum CodingKeys: String, CodingKey {
        case pairing = "pairingText"
    }
}
