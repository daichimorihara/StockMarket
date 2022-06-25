//
//  QuoteService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/11.
//

import Foundation
import Combine

class QuoteService {
    @Published var stocks = [Quote]()
    
    var quoteSubscription: AnyCancellable?
    
    init() {
        
    }
    
    func getQuote(for symbol: String) {
        let urlString = APIManager.getQuoteURLString(for: symbol)
        guard let url = URL(string: urlString) else { return }
        
        quoteSubscription = NetworkingManager.download(url: url)
            .decode(type: StockModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedStock in
                guard let self = self else { return }
                let stock = returnedStock.globalQuote
                
                if !self.stocks.contains(where: { $0.symbol == stock.symbol }) {
                    self.stocks.append(stock)
                }
                self.quoteSubscription?.cancel()
            }       
    }
    
    func getStocks(entities: [WatchListEntity]) {
        var internalStocks = [Quote]()
        
        entities.forEach { entity in
            let urlString = APIManager.getQuoteURLString(for: entity.symbol ?? "")
            guard let url = URL(string: urlString) else { return }
            
            quoteSubscription = NetworkingManager.download(url: url)
                .decode(type: StockModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedStock in
                    guard let self = self else { return }
                    let stock = returnedStock.globalQuote
                    internalStocks.append(stock)
                    self.quoteSubscription?.cancel()
                }
        }
        self.stocks = internalStocks
    }
    
    func deleteQuote(for symbol: String) {
        if let index = stocks.firstIndex(where: { $0.symbol == symbol }) {
            stocks.remove(at: index)
        }
    }
    
    func fetchImages(symbols: [String]) async throws -> [Quote] {
        var urlStrings: [String] = []
        for symbol in symbols {
            urlStrings.append(APIManager.getQuoteURLString(for: symbol))
        }
        
        return try await withThrowingTaskGroup(of: Quote?.self) { group in
            var quotes: [Quote] = []
            
            for urlString in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
            for try await quote in group {
                if let quote = quote {
                    quotes.append(quote)
                }
            }
            
            return quotes
        }
        
    }
    
    private func fetchImage(urlString: String) async throws -> Quote {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoded = try? JSONDecoder().decode(StockModel.self, from: data) {
                return decoded.globalQuote
            } else {
                throw URLError(.badURL)
            }

        } catch {
            throw error
        }
    }
    
}
