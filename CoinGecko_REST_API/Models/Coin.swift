//
//  Coin.swift
//  CoinGecko_REST_API
//
//  Created by Mitya Kim on 7/29/22.
//

import Foundation

struct Coin: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: ImageURL
    let market: MarketData
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case market = "market_data"
    }
}

struct ImageURL: Decodable {
    let small: String
    let large: String
}

struct MarketData: Decodable {
    let marketCapRank: Int
    let price: CurrentPrice
    let priceChange24H: Double
    let priceChange24HPercentage: Double
    let priceChange7DPercentage: Double
    let priceChange14DPercentage: Double
    let priceChange30DPercentage: Double
    let priceChange60DPercentage: Double
    let priceChange200DPercentage: Double
    let priceChange1YearPercentage: Double
    let totalSupply: String?
   
    enum CodingKeys: String, CodingKey {
        case marketCapRank = "market_cap_rank"
        case price = "current_price"
        case priceChange24H = "price_change_24h"
        case priceChange24HPercentage = "price_change_percentage_24h"
        case priceChange7DPercentage = "price_change_percentage_7d"
        case priceChange14DPercentage = "price_change_percentage_14d"
        case priceChange30DPercentage = "price_change_percentage_30d"
        case priceChange60DPercentage = "price_change_percentage_60d"
        case priceChange200DPercentage = "price_change_percentage_200d"
        case priceChange1YearPercentage = "price_change_percentage_1y"
        case totalSupply = "total_supply"
    }
}

struct CurrentPrice: Decodable {
    let usd: Double
    
    enum CodingKeys: String, CodingKey {
        case usd = "usd"
    }
}
