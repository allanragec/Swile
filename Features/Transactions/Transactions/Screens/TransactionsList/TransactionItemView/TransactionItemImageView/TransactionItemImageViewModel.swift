//
//  TransactionItemImageViewModel.swift
//  Transactions
//
//  Created by Allan Melo on 01/05/23.
//

import Components
import Combine
import SwiftUI
import TransactionsAPI

class TransactionItemImageViewModel: ObservableObject {
    var transaction: TransactionsAPI.Transaction
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
    
    var isLargeImageResized: Bool {
        transaction.largeIconURL != nil
    }
    
    var largeIconName: String {
        transaction.largeIconName
    }
    
    var smallIconName: String {
        "icon_small_\(transaction.smallIcon.category.rawValue)"
    }
    
    var largeIconBackgrounColor: Color {
        return transaction.getBackgroundColor()
    }
    
    var largeIconBorderColor: Color {
        return transaction.getBorderColor()
    }
}

