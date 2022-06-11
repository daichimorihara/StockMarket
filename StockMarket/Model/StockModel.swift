//
//  StockModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/09.
//

import Foundation


struct StockModel: Codable {
    let globalQuote: Quote
    
    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}

// MARK: - GlobalQuote
struct Quote: Identifiable {
    var id = UUID().uuidString
    
    let symbol, open, high, low, price, volume, latestTradingDay: String
    let previousClose, change, changePercent: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case latestTradingDay = "07. latest trading day"
        case previousClose = "08. previous close"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
}

extension Quote: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decode(String.self, forKey: .symbol)
        open = try values.decode(String.self, forKey: .open)
        high = try values.decode(String.self, forKey: .high)
        low = try values.decode(String.self, forKey: .low)
        price = try values.decode(String.self, forKey: .price)
        volume = try values.decode(String.self, forKey: .volume)
        latestTradingDay = try values.decode(String.self, forKey: .latestTradingDay)
        previousClose = try values.decode(String.self, forKey: .previousClose)
        change = try values.decode(String.self, forKey: .change)
        changePercent = try values.decode(String.self, forKey: .changePercent)
    }
}

extension Quote: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(open, forKey: .open)
        try container.encode(high, forKey: .high)
        try container.encode(low, forKey: .low)
        try container.encode(price, forKey: .price)
        try container.encode(volume, forKey: .volume)
        try container.encode(latestTradingDay, forKey: .latestTradingDay)
        try container.encode(previousClose, forKey: .previousClose)
        try container.encode(change, forKey: .change)
        try container.encode(changePercent, forKey: .changePercent)
    }
}
