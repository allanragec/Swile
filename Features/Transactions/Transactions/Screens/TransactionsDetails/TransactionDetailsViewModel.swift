//
//  TransactionDetailsViewModel.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Combine
import Components
import SwiftUI
import TransactionsAPI

class TransactionDetailsViewModel: ObservableObject {
    let transaction: TransactionsAPI.Transaction
    private var largeImageLoaderCancellable: AnyCancellable?
    private var smallImageLoaderCancellable: AnyCancellable?
    
    @Published var largeImage: UIImage? = nil
    @Published var smallImage: UIImage? = nil
    
    private let cache = ImageCache.shared
    
    init(_ transaction: TransactionsAPI.Transaction) {
        self.transaction = transaction
        
        setupSmallImage()
        setupLargeImage()
    }
    
    var title: String {
        transaction.name
    }
    
    var subtitle: String {
        let formatter = DateFormatter.dayMonthFormatter
        formatter.locale = Locale(identifier: "fr_FR")
        let date = formatter.string(from: transaction.date)
        
        guard let message = transaction.message else {
            return date
        }
        
        return "\(date) ・ \(message)"
    }
    var isPayment: Bool {
        transaction.type == .payment
    }
    var isLargeImageResized: Bool {
        transaction.largeIconURL != nil
    }
    
    var paymentPrice: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.string(from: transaction.amount.value as NSNumber) else {
            return "-"
        }
        
        return "+\(value) \(transaction.amount.currency.symbol)"
    }
    
    var price: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.string(from: transaction.amount.value as NSNumber) else {
            return "-"
        }
        
        return "\(value) \(transaction.amount.currency.symbol)"
    }
    
    func setupSmallImage() {
        if
            let smallIconURL = transaction.smallIconURL,
            let url = URL(string: smallIconURL)
        {
            if let image = cache[url.absoluteString] {
                self.smallImage = image
            }
            else {
                smallImageLoaderCancellable = ImageLoader(urlString: smallIconURL)
                    .load()
                    .receive(on: DispatchQueue.main)
                    .sink { _ in
                    } receiveValue: { image in
                        self.smallImage = image
                    }
            }
        }
        else {
            smallImage = UIImage(named: transaction.smallIconName)
        }
    }
    
    func setupLargeImage() {
        if
            let largeIconURL = transaction.largeIconURL,
            let url = URL(string: largeIconURL)
        {
            if let image = cache[url.absoluteString] {
                self.largeImage = image
            }
            else {
                smallImageLoaderCancellable = ImageLoader(urlString: largeIconURL)
                    .load()
                    .receive(on: DispatchQueue.main)
                    .sink { _ in
                    } receiveValue: { image in
                        self.largeImage = image
                    }
            }
        }
        else {
            largeImage = UIImage(named: transaction.largeIconName)
        }
    }
}

