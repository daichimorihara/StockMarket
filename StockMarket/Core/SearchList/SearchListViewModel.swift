//
//  SearchListViewModel.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import Foundation
import Combine

@MainActor
class SearchListViewModel: ObservableObject {
    @Published var matches = [BestMatch]()
    @Published var searchText: String = ""
    
    @Published var entities = [WatchListEntity]()
    
    var cancellables = Set<AnyCancellable>()
    
    let watchListService = WatchListService.instance
    let searchService = SearchService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard !text.isEmpty else {
                    self?.matches = []
                    return
                }
                Task {
                    if let savedMatches = try? await self?.searchService.fetchMatches(keywords: text) {
                        self?.matches = savedMatches
                    }
                }
            }
            .store(in: &cancellables)
        
        watchListService.$savedEntities
            .sink { [weak self] returnedEntities in
                self?.entities = returnedEntities
            }
            .store(in: &cancellables)
    }
    
    func updateWatchList(match: BestMatch) {
        watchListService.update(match: match)
    }
    
    func isInWatchList(match: BestMatch) -> Bool {
        return watchListService.isInWatchList(match: match)
    }
}
