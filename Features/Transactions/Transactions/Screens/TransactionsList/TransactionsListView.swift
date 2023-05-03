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
    @StateObject var viewModel = TransactionsListViewModel()
    @State var detailTransaction: TransactionsAPI.Transaction?
    @EnvironmentObject private var screenState: DetailsScreenStepStateManager
    @State var canStartNewAnimation: Bool = true
    
    public init() {
        self.detailTransaction = nil
    }
    
    fileprivate func section(_ section: TransactionSection) -> some View {
        return Section(
            header:  HStack {
                Text(section.month)
                    .padding(.leading, 25)
                    .font(.custom("Segma-Medium", size: 13))
                    .foregroundColor(Color(hex: 0x918BA6))
                    .frame(alignment: .leading)
                Spacer()
            }
        ) {
            ForEach(section.transactions) { transaction in
                TransactionItemView(transaction,
                                    detailTransaction: self.$detailTransaction,
                                    namespace: namespace
                )
                .onTapGesture {
                    guard self.canStartNewAnimation  else { return }
                    withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                        self.detailTransaction = transaction
                    }
                }
                .frame(height: 66, alignment: .center)
            }
        }
        .frame(alignment: .leading)
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
                    canStartNewAnimation: $canStartNewAnimation,
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
