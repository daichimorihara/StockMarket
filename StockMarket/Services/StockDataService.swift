//
//  StockDataService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/10.
//

import Foundation
import Combine

class StockDataService {
    @Published var stock: StockModel?
    
    var stockSubscription: AnyCancellable?
    
    init() {
        getStock()
    }
    
    func getStock() {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=118SLI3Y8HKS6G0O") else {
            print("Fail to fetch URL")
            return
        }
        
        stockSubscription = NetworkingManager.download(url: url)
            .decode(type: StockModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedStock in
                self?.stock = returnedStock
                self?.stockSubscription?.cancel()
            })
    }
    
}
