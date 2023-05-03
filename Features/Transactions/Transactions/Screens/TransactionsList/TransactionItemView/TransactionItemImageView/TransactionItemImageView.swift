//
//  TransactionItemImageView.swift
//  Transactions
//
//  Created by Allan Melo on 01/05/23.
//

import Components
import SwiftUI
import TransactionsAPI

struct TransactionItemImageView: View {
    @StateObject var viewModel: TransactionItemImageViewModel
    let namespace: Namespace.ID
    
    init(_ transaction: TransactionsAPI.Transaction, namespace: Namespace.ID) {
        let viewModel = TransactionItemImageViewModel(transaction)
        _viewModel = StateObject(wrappedValue: viewModel)
        self.namespace = namespace
    }
    
    var smallIconView: some View {
        Group {
            if let image = viewModel.smallImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
        .frame(width: 22, height: 22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-smallIconView", in: namespace)
        .frame(width: 66, height: 66, alignment: .bottomTrailing)
    }
    
    var largeIconView: some View {
        Group {
            if let image = viewModel.largeImage {
                if viewModel.isLargeImageResized {
                    Image(uiImage: image)
                        .resizable()
                }
                else {
                    Image(uiImage: image)
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
        }
        .frame(width: 56, height: 56)
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(viewModel.largeIconBorderColor, lineWidth: 1)
                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-RoundedRectangle", in: namespace)
        )
        .background(
            viewModel.largeIconBackgrounColor
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-background", in: namespace)
        )
        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-image", in: namespace)
        
    }
    
    var body: some View {
        Group {
            ZStack {
                largeIconView
                smallIconView
            }
        }
        .scaledToFill()
        .frame(width: 66, height: 66)
    }
}

struct TransactionItemImageView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ForEach(
            ColorScheme.allCases,
            id: \.self,
            content:  TransactionItemImageView(.init(
                name: "Sushi",
                type: .mealVoucher,
                date: Date(),
                message: nil,
                amount: .init(value: -50,
                              currency: .init(
                                iso: "EUR",
                                symbol: "€",
                                title: "Euro"
                              )),
                smallIcon: .init(url: nil, category: .mealVoucher),
                largeIcon: .init(url: nil, category: .computer)), namespace: namespace
            )
            .preferredColorScheme
        )
    }
}
