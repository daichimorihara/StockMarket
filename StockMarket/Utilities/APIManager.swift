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

class APIManager {
    
    
    static func getQuoteURLString(for symbol: String) -> String {
        getBaseURLString(type: .quote, q: "symbol", a: symbol)
    }
    
    static func getSearchURLString(for keywords: String) -> String {
        getBaseURLString(type: .search, q: "keywords", a: keywords)
    }
    
    static func getBaseURLString(type: FuncType, q: String, a: String) -> String {
        return "https://www.alphavantage.co/query?function=\(type.rawValue)&\(q)=\(a)&apikey=118SLI3Y8HKS6G0O"
    }
    
    enum FuncType: String {
        case quote = "GLOBAL_QUOTE"
        case search = "SYMBOL_SEARCH"
     //   case daily
     //   case intraday
    }
    

}
