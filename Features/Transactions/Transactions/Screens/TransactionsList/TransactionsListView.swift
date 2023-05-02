//
//  TransactionsList.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import SwiftUI
import Components
import TransactionsAPI

public struct TransactionsListView: View {
    @Namespace var namespace
    @ObservedObject var viewModel = TransactionsListViewModel()
    @State var detailTransaction: TransactionsAPI.Transaction?
    
    public init() {
        self.detailTransaction = nil
    }
    
    fileprivate func section(_ section: TransactionSection) -> some View {
        return Section(header: Text(section.month).padding([.leading], 4)) {
            ForEach(section.transactions) { transaction in
                TransactionItemView(transaction,
                                    detailTransaction: self.$detailTransaction,
                                    namespace: namespace
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.8, dampingFraction: 1)) {
                        self.detailTransaction = transaction
                    }
                }
                .frame(height: 66, alignment: .center)
            }
        }
        .frame(alignment: .leading)
        .textCase(nil)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
    
    fileprivate func listView() -> some View {
        NavigationView {
            LoadingView(
                isRunning: $viewModel.isLoading,
                title: viewModel.loadingTransactionsTitle
            ) {
                ScrollView {
                    ForEach(self.viewModel.sections) { transactionSection in
                        section(transactionSection)
                    }
                }
                .scrollContentBackground(.hidden)
                .refreshable {
                    await viewModel.getTransactionsAsync()
                }
                .navigationTitle(viewModel.title)
                .toastView(toast: $viewModel.toast)
                .modifier(AppPreferences())
            }
        }
        .modifier(AppPreferences())
    }
    
    public var body: some View {
        ZStack {
            listView()
            if let transaction = detailTransaction {
                TransactionDetailsView(
                    transaction,
                    detailTransaction: $detailTransaction,
                    namespace: namespace
                )
            }
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
