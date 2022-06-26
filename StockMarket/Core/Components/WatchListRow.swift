//
//  WatchListRow.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import SwiftUI

struct WatchListRow: View {
    
    let stock: Quote
    
    init(stock: Quote) {
        self.stock = stock
    }
  
    var price: Double {
        Double(stock.price) ?? 0.0
    }
    
    var change: Double {
        Double(stock.change) ?? 0.0
    }
    
    var changePercent: Double {
        Double(stock.changePercent.dropLast()) ?? 0.0
    }
    
    var changePositive: Bool {
        (Double(stock.change) ?? 0) >= 0
    }
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            centerColumn
            rightColumn
        }
        .padding(.trailing, 5)
        .contentShape(Rectangle())
    }
}

struct WatchListRow_Previews: PreviewProvider {
    static var previews: some View {
        WatchListRow(stock: dev.stock)
    }
}

extension WatchListRow {
    
    private var leftColumn: some View {
        HStack {
            Rectangle()
                .frame(width: 4, height: 50)
                .foregroundColor(changePositive ? .theme.green : .theme.red)
            
            Text(stock.symbol)
                .font(.headline)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack {
            Text(String(format: "%.2f", price))
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            HStack(spacing: 0) {
                Text(Date(alphaString: stock.latestTradingDay).asShortDateString())
                
                Text(" EDT")
                
            }
            .font(.caption)
            .foregroundColor(.theme.secondary)
 
        }
    }
    
    var rightColumn: some View {
        VStack {
            Text(String(format: "%.2f", change))
                .font(.subheadline)
            Text(String(format: "%.2f", changePercent) + "%")
                .font(.caption)
        }
        .foregroundColor(changePositive ? .theme.green : .theme.red)
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
