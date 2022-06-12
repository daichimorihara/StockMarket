//
//  SearchService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import Foundation
import Combine

class SearchService {
    @Published var matches = [BestMatch]()
    
    var searchSubscription: AnyCancellable?
    
    init() {
        
    }
    
    func searchStocks(for keywords: String) {
        let urlString = APIManager.getSearchURLString(for: keywords)
        guard let url = URL(string: urlString) else { return }
        
        searchSubscription = NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedSearchModel in
                self?.matches = returnedSearchModel.bestMatches
                self?.searchSubscription?.cancel()
            }
    }
}
