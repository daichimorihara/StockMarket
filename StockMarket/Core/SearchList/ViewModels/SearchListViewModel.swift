//
//  SearchListViewModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import Foundation
import Combine

class SearchListViewModel: ObservableObject {
    @Published var matches = [BestMatch]()
    @Published var searchText = ""
    
    let searchService = SearchService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                guard !value.isEmpty else {
                    self?.matches = []
                    return
                }
                self?.searchStocks(keywords: value)
            }
            .store(in: &cancellables)
        
        searchService.$matches
            .sink { [weak self] returnedMatches in
                self?.matches = returnedMatches
            }
            .store(in: &cancellables)
    }
    
    
    
    func searchStocks(keywords: String) {
        searchService.searchStocks(for: keywords)
    }
    
}
