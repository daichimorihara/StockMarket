//
//  SearchListRow.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import SwiftUI

struct SearchListRow: View {
    
    let match: BestMatch

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(match.symbol)
                    .font(.headline)
                    .foregroundColor(.theme.accent)
                
                Text(match.region)
                    .font(.caption)
                    .foregroundColor(.theme.secondary)
                
                Text(match.currency)
                    .font(.caption)
                    .foregroundColor(.theme.secondary)

                Spacer()
            }
            
            Text(match.name)
                .font(.caption)
                .foregroundColor(.theme.secondary)
        }
        .contentShape(Rectangle())
        
        
    }
}

struct SearchListRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchListRow(match: dev.match)
    }
}


