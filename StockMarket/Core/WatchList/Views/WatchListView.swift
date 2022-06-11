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
    
    var body: some View {
  
        VStack {
            
            TextField("Symbol here...", text: $symbolText)
                .frame(height: 50)
                .background(.gray.opacity(0.2))
                .padding()
            
            Button {
                vm.getStock(for: symbolText)
            } label: {
                Text("Add Watch List")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }
            .padding()


            
            List {
                ForEach(vm.stocks) { stock in
                    Text(stock.symbol)
                }
            }
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
