//
//  SearchListRow.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import SwiftUI

struct SearchListRow: View {
    
    let match: BestMatch
    var isInWatchList: Bool
    let updateWatchList: () -> ()

//    init(match: BestMatch, isInWatchList: Bool) {
//        self.match = match
//        self.isInWatchList = isInWatchList
//    }
    
    
    var body: some View {
        HStack {
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
            
            Button {
                updateWatchList()
            } label: {
                Text(isInWatchList ? "Delete" : "+ Watchlist")
                    .foregroundColor(.theme.accent)
                    .padding(5)
                    .background(
                        Color.theme.accent.opacity(0.2)
                    )
            }

            
        }
        
        
    }
}

struct SearchListRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchListRow(match: dev.match, isInWatchList: true, updateWatchList: {})
    }
}


