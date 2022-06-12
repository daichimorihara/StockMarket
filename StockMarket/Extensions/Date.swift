//
//  Date.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import Foundation

extension Date {
    
    init(alphaString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: alphaString) ?? Date()
        self.init(timeInterval: 0, since: date)
        
        
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }
    
    func asShortDateString() -> String {
        return self.shortFormatter.string(from: self)
    }
    
}
