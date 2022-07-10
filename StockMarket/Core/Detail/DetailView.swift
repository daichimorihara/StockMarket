//
//  DetailView.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/27.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var stock: Quote?
    @Binding var name: String?
    
    var body: some View {
        ZStack {
            if let stock = stock,
               let name = name {
                DetailView(stock: stock, name: name)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var vm = DetailViewModel()

    let stock: Quote
    let name: String
    
    init(stock: Quote, name: String) {
        self.stock = stock
        self.name = name
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                title
                chartTitle
                ChartVIew(data: vm.chartData)
                stats
            }
            Spacer()
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.fetchChartData(symbol: stock.symbol)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(stock: dev.stock, name: "Ford Inc")
    }
}

extension DetailView {
    var price: Double {
        Double(stock.price) ?? 0.0
    }
    
    var open: Double {
        Double(stock.open) ?? 0.0
    }
    
    var high: Double {
        Double(stock.high) ?? 0.0
    }
    
    var low: Double {
        Double(stock.low) ?? 0.0
    }
    var previousClose: Double {
        Double(stock.previousClose) ?? 0.0
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
    
    
    private var title: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.theme.secondary)
            
            Text(String(price))
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(.theme.accent)
            
            HStack(spacing: 0) {
                Image(systemName: "triangle.fill")
                    .rotationEffect(Angle(degrees: changePositive ? 0.0 : 180))
                
                Text(String(format: "%.2f", change))
                
                Text(" (\(String(format: "%.2f", changePercent))%)")
            }
            .foregroundColor(changePositive ? .theme.green : .theme.red)
            .font(.headline)
        }
        .padding(.vertical)
        .padding(.horizontal ,5)
    }
    
    private var chartTitle: some View {
        Text("Last 30 days Chart")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.theme.secondary)
            .padding(.horizontal, 5)
    }
    
    private var stats: some View {
        VStack(alignment: .leading) {
            Text("KEY STATS")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.theme.accent)
            
            
            StatsRow(metric: "Volume", number: stock.volume)
            StatsRow(metric: "Open", number: String(format: "%.2f", open))
            StatsRow(metric: "High", number: String(format: "%.2f", high))
            StatsRow(metric: "Low", number: String(format: "%.2f", low))
            StatsRow(metric: "Price", number: String(format: "%.2f", price))
            StatsRow(metric: "Latest Traiding Day", number: stock.latestTradingDay)
            StatsRow(metric: "Previous Close", number: String(format: "%.2f", previousClose))
        }
        .padding(.vertical)
        .padding(.horizontal, 5)
    }
}
