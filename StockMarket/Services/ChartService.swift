//
//  ChartService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/27.
//

import Foundation

class ChartService {
    
    func fetchChart(symbol: String) async throws -> [TimeSeriesDaily] {
        let urlString = APIManager.getChartURL(symbol: symbol)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoded = try? JSONDecoder().decode(ChartModel.self, from: data) {
                let values = decoded.timeSeriesDaily.values
                return Array(values)
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
    func fetchChartData(symbol: String) async throws -> [Double] {
        let urlString = APIManager.getChartURL(symbol: symbol)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoded = try? JSONDecoder().decode(ChartModel.self, from: data) {
                let dic = decoded.timeSeriesDaily.sorted(by: { $0.key > $1.key }).prefix(30)
                
                var returnedData = [Double]()

                for (_, value) in dic {
                    returnedData.append(Double(value.close) ?? 0.0)
                }

                return returnedData
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
        
    }
        
}
