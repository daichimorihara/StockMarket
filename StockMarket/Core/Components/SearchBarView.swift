//
//  SearchBarView.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .theme.secondary : .theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(.theme.accent)
        }
        .overlay(
            Image(systemName: "xmark.circle.fill")
                .padding()
                .foregroundColor(.theme.accent)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    searchText = ""
                }
            
            ,alignment: .trailing
        )
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("APPL"))
    }
}
