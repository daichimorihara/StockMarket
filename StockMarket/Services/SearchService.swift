//
//  SearchService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import Foundation
import Combine

class SearchService {
 
    func fetchMatches(keywords: String) async throws -> [BestMatch] {
        let urlString = APIManager.getSearchURL(keywords: keywords)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoded = try? JSONDecoder().decode(SearchModel.self, from: data) {
                return decoded.bestMatches
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}
