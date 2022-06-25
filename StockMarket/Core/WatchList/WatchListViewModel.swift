//
//  WatchListViewModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/10.
//

import Foundation
import Combine
import SwiftUI

class WatchListViewModel: ObservableObject {
    @Published var stocks = [Quote]()
    @Published var entities = [WatchListEntity]()
    @Published var searchText = ""
    
    var symbols: [String] {
        var tentitive = [String]()
        entities.forEach { entity in
            tentitive.append(entity.symbol ?? "")
        }
        return tentitive
    }
    
    
    
    func getStocks() {
        quoteService.getStocks(entities: entities)
    }
    
    let quoteService = QuoteService()
    let watchlistService = WatchListService.instance
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        watchlistService.$savedEntities
            .combineLatest(quoteService.$stocks)
            .map { (entities, quotes) -> [Quote] in
                quotes
                    .compactMap { quote -> Quote? in
                        guard entities.first(where: { $0.symbol == quote.symbol }) != nil else {
                            return nil
                        }
                        return quote
                    }
            }
            .sink { [weak self] returnedStocks in
                self?.stocks = returnedStocks
            }
            .store(in: &cancellables)
        
        watchlistService.$savedEntities
            .sink { [weak self] returnedEntities in
                self?.entities = returnedEntities
            }
            .store(in: &cancellables)
        
//        watchlistService.$savedEntities
//            .sink { [weak self] returnedEntities in
//                self?.quoteService.stocks = []
//                for entity in returnedEntities {
//                    self?.getStock(for: entity.symbol ?? "")
//                }
//            }
//            .store(in: &cancellables)
//
//        quoteService.$stocks
//            .sink { [weak self] returnedStocks in
//                self?.stocks = returnedStocks
//            }
//            .store(in: &cancellables)
        
  
    }
    
    
    
    func getStock(for symbol: String) {
        quoteService.getQuote(for: symbol)
    }
    
    func deleteStock(for symbol: String) {
        quoteService.deleteQuote(for: symbol)
    }
    
    func downloadImages() async {
        if let images = try? await quoteService.fetchImages(symbols: symbols) {
            await MainActor.run {
                self.stocks = images
            }
        }
    }
    
    
    
}
