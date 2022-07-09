//
//  DetailViewModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/27.
//

import Foundation


class DetailViewModel: ObservableObject {
    
    //@Published var chartData = [TimeSeriesDaily]()
    @Published var chartData = [Double]()
    
    let chartService = ChartService()
    
//    func fetchChartData(symbol: String) async {
//        if let returnedChartData = try? await chartService.fetchChart(symbol: symbol) {
//            chartData = returnedChartData
//        }
//    }
    func fetchChartData(symbol: String) async {
        if let returnedChartData = try? await chartService.fetchChartData(symbol: symbol) {
            chartData = returnedChartData
        }
    }
}
