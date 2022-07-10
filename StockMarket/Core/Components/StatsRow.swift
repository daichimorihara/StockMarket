//
//  StatsRow.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/07/10.
//

import SwiftUI

struct StatsRow: View {
    
    let metric: String
    let number: String
    
    var body: some View {
        HStack {
            Text(metric)
            Spacer()
            Text(number)
        }
        .foregroundColor(.theme.accent)
        .font(.system(size: 15, weight: .semibold))
        .padding(.vertical, 2)
    }
}

struct StatsRow_Previews: PreviewProvider {
    static var previews: some View {
        StatsRow(metric: "Volume", number: "44,898,094")
    }
}
