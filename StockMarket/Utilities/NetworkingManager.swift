//
//  NetworkingManager.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/11.
//

import Foundation
import Combine

class NetworkingManager {
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleURLResponse)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(data: Data, response: URLResponse) throws -> Data {
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Failed to receive Data \(error)")
        }
    }
    
}
