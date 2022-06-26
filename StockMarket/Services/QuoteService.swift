//
//  QuoteService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/11.
//

import Foundation
import Combine

class QuoteService {
    
    func fetchQuotes(symbols: [String]) async throws -> [Quote] {
        return try await withThrowingTaskGroup(of: Quote?.self, body: { group in
            var quotes: [Quote] = []
            
            for symbol in symbols {
                group.addTask {
                    try? await self.fetchQuote(symbol: symbol)
                }
            }
            
            for try await quote in group {
                if let quote = quote {
                    quotes.append(quote)
                }
            }
            return quotes
        })
    }

    private func fetchQuote(symbol: String) async throws -> Quote {
        let urlString = APIManager.getQuoteURL(symbol: symbol)
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
