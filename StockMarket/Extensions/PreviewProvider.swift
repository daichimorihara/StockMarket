//
//  PreviewProvider.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/11.
//

import Foundation
import SwiftUI


extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    let stock = Quote(symbol: "TWTR", open: "39.99", high: "40.59", low: "37.88", price: "38.9800", volume: "1111111", latestTradingDay: "2022-06-11", previousClose: "38.65", change: "0.33343", changePercent: "1.09435%")
    
    let match = BestMatch(symbol: "TWTR", name: "Twitter Inc", type: "Equaty", region: "United States", marketOpen: "9:30", marketClose: "16:00", timezone: "UTC-4", currency: "USD", matchScore: "0.52")
    
    let data: [Double] = [21, 22, 23, 25, 34, 31, 28, 26, 29, 30, 34, 35, 41, 38, 35, 30, 29, 27, 28, 29, 30, 29]
}


