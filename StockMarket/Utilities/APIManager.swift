//
//  APIManager.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/11.
//

import Foundation

// Quote EndPoint: function symbol apikey
// Search EndPoint: function keywords apikey
// Daily: function symbol apikey
// Intraday: function symbol interval apikey
// https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=BA&apikey=demo
// https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo
// https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo
class APIManager {

    static func getSearchURL(keywords: String) -> String {
        return getBaseURLString(key: .search, q: "keywords", a: keywords)
    }
    
    static func getQuoteURL(symbol: String) -> String {
        return getBaseURLString(key: .quote, q: "symbol", a: symbol)
    }
    
    static func getChartURL(symbol: String) -> String {
        return getBaseURLString(key: .chart, q: "symbol", a: symbol)
    }
    
    static func getBaseURLString(key: URLKey, q: String, a: String) -> String {
        return "https://www.alphavantage.co/query?function=\(key.rawValue)&\(q)=\(a)&apikey=118SLI3Y8HKS6G0O"
    }
    
    
    
    enum URLKey: String {
        case quote = "GLOBAL_QUOTE"
        case search = "SYMBOL_SEARCH"
        case chart = "TIME_SERIES_DAILY"
    }
}
