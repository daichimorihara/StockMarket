//
//  StockMarketApp.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/09.
//

import SwiftUI

@main
struct StockMarketApp: App {
    
    @StateObject var vm = WatchListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WatchListView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
