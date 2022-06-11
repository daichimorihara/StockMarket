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
                let stock = returnedStock.globalQuote
                self?.stocks.append(stock)
                self?.quoteSubscription?.cancel()
            }       
    }
    
    
}
