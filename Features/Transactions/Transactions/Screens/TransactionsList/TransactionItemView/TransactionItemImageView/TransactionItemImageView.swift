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
    @ObservedObject var viewModel: TransactionItemImageViewModel
    let namespace: Namespace.ID
    
    init(_ transaction: TransactionsAPI.Transaction, namespace: Namespace.ID) {
        self.viewModel = .init(transaction)
        self.namespace = namespace
    }
    
    var smallIconView: some View {
        Group {
            Group {
                if let url = viewModel.smallIconURL {
                    ImageView(withURL: url)
                        .frame(width: 16, height: 16)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                else {
                    Image(viewModel.smallIconName)
                }
            }
            .frame(width: 22, height: 22)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-smallIconView", in: namespace)
        .frame(width: 66, height: 66, alignment: .bottomTrailing)
    }
    
    var largeIconView: some View {
        Group {
            Group {
                if let url = viewModel.largeIconURL {
                    ImageView(withURL: url)
                        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-ImageView", in: namespace)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                        )
                }
                else {
                    Image(viewModel.largeIconName)
                        .frame(width: 24, height: 24, alignment: .center)
                        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-image", in: namespace)
                }
            }
        }
        .frame(width: 56, height: 56)
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
