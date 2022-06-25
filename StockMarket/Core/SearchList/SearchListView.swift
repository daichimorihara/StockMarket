//
//  SearchListView.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/12.
//

import SwiftUI

struct SearchListView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = SearchListViewModel()
    @EnvironmentObject var watchVM: WatchListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            searchHeader
            Divider()
            
            Text("QUOTES RESULTS")
                .font(.headline)
                .padding(.leading)
            
            List {
                ForEach(vm.matches) { match in
                    SearchListRow(match: match,
                                  isInWatchList: vm.inWatchList(match: match),
                                  updateWatchList:{
                        vm.updateWatchList(match: match)
                        watchVM.getStock(for: match.symbol)
                    })
                }
            }
            .listStyle(PlainListStyle())
            
            
            
            Spacer()
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
            .environmentObject(dev.watchListVM)
    }
}

extension SearchListView {
    
    private var searchHeader: some View {
        HStack {
            SearchBarView(searchText: $vm.searchText)
            
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 5)
    }
}
