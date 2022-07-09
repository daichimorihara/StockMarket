//
//  DetailView.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/27.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var stock: Quote?
    
    var body: some View {
        ZStack {
            if let stock = stock {
                DetailView(symbol: stock.symbol)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var vm = DetailViewModel()

    let symbol: String
    init(symbol: String) {
        self.symbol = symbol
    }
    
    var body: some View {
        VStack {
            Text(symbol)
                .font(.largeTitle)
            
            ChartVIew(data: vm.chartData)
            
            Spacer()
        }
        .task {
            await vm.fetchChartData(symbol: symbol)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(symbol: "IBM")
    }
}
