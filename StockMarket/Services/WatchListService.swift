//
//  WatchListService.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/13.
//

import Foundation
import CoreData

class WatchListService {
    
    static let instance = WatchListService()
    
    private let container: NSPersistentContainer
    private let containerName = "WatchListContainer"
    private let entityName = "WatchListEntity"
    
    @Published var savedEntities = [WatchListEntity]()
    
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data: \(error)")
            }
            self.getWatchList()
        }
    }
    
    // MARK: PUBLIC
    func updateWatchList(match: BestMatch) {
        if let entity = savedEntities.first(where: { $0.symbol == match.symbol }) {
            delete(entity: entity)
        } else {
            add(match: match)
        }
    }
    
    func isInWatchList(match: BestMatch) -> Bool {
        if savedEntities.first(where: { $0.symbol == match.symbol }) != nil {
            return true
        } else {
            return false
        }
            
    }
    
    
    // MARK: PRIVATE
    private func add(match: BestMatch) {
        let entity = WatchListEntity(context: container.viewContext)
        entity.symbol = match.symbol
        entity.name = match.name
        applyChanges()
    }
    
    private func delete(entity: WatchListEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func getWatchList() {
        let request = NSFetchRequest<WatchListEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch WatchList Entity: \(error)")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save to Core Data: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getWatchList()
    }
    
    
}
