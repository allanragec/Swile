//
//  TransactionsListViewModel.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import SwiftUI
import TransactionsAPI
import Components

class TransactionsListViewModel: ObservableObject {
    @Published var sections: [TransactionSection] = []
    @Published var isLoading: Bool = false
    @Published var toast: Toast? = nil
    
    let service: TransactionsServicing
    
    init(
        service: TransactionsServicing = TransactionsService()
    ) {
        self.service = service
        
        getTransactions()
    }
    
    func getTransactionsAsync() async  {
        do {
            let result = try await service.getTransactionsAsync()
            DispatchQueue.main.async {
                self.createSections(result.transactions)
            }
        }
        catch let error {
            print("Could not get refresh transactions: \(error)")
            DispatchQueue.main.async {
                self.toast = Toast(
                    type: .error,
                    title: self.somethingWrongTitle,
                    message: self.couldNotRefreshTransactionsMessage
                )
            }
        }
    }
    
    private func getTransactions() {
        isLoading = true
        service.getTransactions { result in
            switch result {
            case .success(let transactionsResponse):
                self.createSections(transactionsResponse.transactions)
            case .failure(let error):
                print("Could not get transactions: \(error)")
                self.toast = Toast(
                    type: .error,
                    title: self.somethingWrongTitle,
                    message: self.couldNotLoadTransactionsMessage
                )
            }
            self.isLoading = false
        }
    }
    
    private func createSections(_ transactions: [TransactionsAPI.Transaction]) {
        let sections = Dictionary(grouping: transactions) { (transaction) -> String in
            transaction.dateMonth
        }.map { item in
            TransactionSection(
                dateMonth: item.key,
                transactions: item.value
            )
        }
            .sorted(by: { $0.dateMonth > $1.dateMonth })
        self.sections = sections
    }
}
