//
//  WatchListView.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/10.
//

import SwiftUI

struct WatchListView: View {
    
    @StateObject var vm = WatchListViewModel()
    @State private var symbolText = ""
    @State private var showSearchView = false
    
    var body: some View {
  
        VStack {
            customHeader
            Divider()
            listTitle
            stockList

            Spacer()
        }
        .task {
            await vm.fetchQuotes()
        }
        .fullScreenCover(isPresented: $showSearchView) {
            SearchListView()
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}

extension WatchListView {
    
    private var customHeader: some View {
        HStack {
            Spacer()
            Text("My Watchlist")
                .bold()
            Spacer()
            Button {
                showSearchView.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .foregroundColor(.theme.accent)
        .padding()
    }
    
    private var listTitle: some View {
        HStack {
            Text("List")
                .fontWeight(.semibold)
                .foregroundColor(.theme.accent)

            Spacer()
            Text("Price")
                .fontWeight(.semibold)
                .foregroundColor(.theme.accent)
            
            Text("% Change")
                .foregroundColor(.theme.accent)
                .bold()
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .padding(.horizontal)
    }
    
    private var stockList: some View {
        List {
            ForEach(vm.stocks) { stock in
                WatchListRow(stock: stock)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 0,
                                         trailing: 0)
                    )
            }
        }
        .listStyle(PlainListStyle())
    }
}
