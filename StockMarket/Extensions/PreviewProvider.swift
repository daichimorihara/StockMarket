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
    
    let stock = Quote(symbol: "TWTR", open: "39.99", high: "40.59", low: "37.88", price: "38.98", volume: "1111111", latestTradingDay: "2022-06-11", previousClose: "38.65", change: "0.33", changePercent: "1.09%")
    
    let match = BestMatch(symbol: "TWTR", name: "Twitter Inc", type: "Equaty", region: "United States", marketOpen: "9:30", marketClose: "16:00", timezone: "UTC-4", currency: "USD", matchScore: "0.52")
    
    let watchListVM = WatchListViewModel()
}
