//
//  ChartModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/27.
//

import Foundation

// MARK: - Welcome
struct ChartModel: Decodable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }

}

// MARK: - MetaData
struct MetaData {
    let info: String
    let symbol: String
    let lastRef: String
    let outputSize: String
    let timeZone: String
    
    enum CodingKeys: String, CodingKey {
        case info = "1. Information"
        case symbol = "2. Symbol"
        case lastRef = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}

extension MetaData: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decode(String.self, forKey: .info)
        symbol = try values.decode(String.self, forKey: .symbol)
        lastRef = try values.decode(String.self, forKey: .lastRef)
        outputSize = try values.decode(String.self, forKey: .outputSize)
        timeZone = try values.decode(String.self, forKey: .timeZone)
    }
}


// MARK: - TimeSeriesDaily
struct TimeSeriesDaily: Identifiable {
    var id = UUID().uuidString
    
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}

extension TimeSeriesDaily: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        open = try values.decode(String.self, forKey: .open)
        high = try values.decode(String.self, forKey: .high)
        low = try values.decode(String.self, forKey: .low)
        close = try values.decode(String.self, forKey: .close)
        volume = try values.decode(String.self, forKey: .volume)
    }
}
