//
//  SearchModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import Foundation

struct SearchModel: Decodable {
    let bestMatches: [BestMatch]
}

// MARK: - BestMatch
struct BestMatch: Identifiable {
    var id = UUID().uuidString
    let symbol, name, type, region, marketOpen: String
    let marketClose, timezone, currency, matchScore: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timezone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
    }
}

extension BestMatch: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decode(String.self, forKey: .symbol)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        region = try values.decode(String.self, forKey: .region)
        marketOpen = try values.decode(String.self, forKey: .marketOpen)
        marketClose = try values.decode(String.self, forKey: .marketClose)
        timezone = try values.decode(String.self, forKey: .timezone)
        currency = try values.decode(String.self, forKey: .currency)
        matchScore = try values.decode(String.self, forKey: .matchScore)
    }
}
