//
//  WatchListViewModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/10.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class WatchListViewModel: ObservableObject {
    @Published var stocks = [Quote]()
    @Published var entities = [WatchListEntity]()
    
    var cancellables = Set<AnyCancellable>()
    let quoteService = QuoteService()
    let watchListService = WatchListService.instance
    
    init() {
        addSubscribers()
    }
    
    var symbols: [String] {
        var dataArray: [String] = []
        for entity in entities {
            dataArray.append(entity.symbol ?? "")
        }
        return dataArray
    }
    
    func addSubscribers() {
        watchListService.$savedEntities
            .sink { [weak self] returnedEntities in
                self?.entities = returnedEntities
                Task {
                    await self?.fetchQuotes()
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchQuotes() async {
        if let returnedStocks = try? await quoteService.fetchQuotes(symbols: symbols) {
            stocks = returnedStocks
        }
    }
}
