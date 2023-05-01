//
//  TransactionsList.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import SwiftUI
import Components

public struct TransactionsListView: View {
    @ObservedObject var viewModel = TransactionsListViewModel()
    
    public init() {}
    
    fileprivate func section(_ item: TransactionSection) -> some View {
        return Section(header: Text(item.month).padding([.leading], 4)) {
            ForEach(item.transactions) { item in
                TransactionItemView(item)
            }
        }
        .textCase(nil)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
    
    public var body: some View {
        LoadingView(
            isRunning: $viewModel.isLoading,
            title: viewModel.loadingTransactionsTitle
        ) {
            NavigationView {
                List {
                    ForEach(self.viewModel.sections) { item in
                        section(item)
                    }
                }
                .scrollContentBackground(.hidden)
                .refreshable {
                    await viewModel.getTransactionsAsync()
                }
                .navigationTitle(viewModel.title)
            }
            .toastView(toast: $viewModel.toast)
            .modifier(AppPreferences())
        }
    }
}

struct TransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(
            ColorScheme.allCases,
            id: \.self,
            content: TransactionsListView().preferredColorScheme
        )
    }
}
