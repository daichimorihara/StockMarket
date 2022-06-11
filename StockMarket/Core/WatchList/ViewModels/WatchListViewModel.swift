//
//  WatchListViewModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/10.
//

import Foundation
import Combine

class WatchListViewModel: ObservableObject {
    @Published var stocks = [Quote]()
    
    let quoteService = QuoteService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        quoteService.$stocks
            .sink { [weak self] returnedStocks in
                self?.stocks = returnedStocks
            }
            .store(in: &cancellables)
    }
    
    func getStock(for symbol: String) {
        quoteService.getQuote(for: symbol)
    }
}
