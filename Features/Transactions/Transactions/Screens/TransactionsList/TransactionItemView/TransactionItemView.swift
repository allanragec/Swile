//
//  TransactionItemView.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Components
import SwiftUI
import TransactionsAPI

struct TransactionItemView: View {
    @ObservedObject var viewModel: TransactionItemViewModel
    
    init(_ transaction: TransactionsAPI.Transaction) {
        self.viewModel = .init(transaction)
    }
    
    var body: some View {
        HStack {
            TransactionItemImageView(viewModel.transaction)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(viewModel.title)
                        .font(.custom("Segma-Medium", size: 15))
                        .foregroundColor(Color(hex: 0x1D1148))
                        .frame(alignment: .leading)
                    
                    Spacer()
                    
                    if viewModel.isPayment {
                        Text(viewModel.paymentPrice)
                            .font(.custom("Segma-Medium", size: 15))
                            .padding(6)
                            .foregroundColor(Color(hex: 0x633FD3))
                            .background(Color(hex: 0xE6E0F8))
                            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                    }
                    else {
                        Text(viewModel.price)
                            .font(.custom("Segma-Medium", size: 15))
                            .foregroundColor(Color(hex: 0x1D1148))
                            .frame(alignment: .trailing)
                    }
                }
                
                Text(viewModel.subtitle)
                    .font(.custom("Segma-Medium", size: 12))
                    .foregroundColor(Color(hex: 0x918BA6))
                    .frame(alignment: .leading)
            }
        }
    }
}

struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(.init(
            name: "Sushi",
            type: .payment,
            date: Date(),
            message: nil,
            amount: .init(value: 50,
                          currency: .init(
                            iso: "EUR",
                            symbol: "€",
                            title: "Euro")),
            smallIcon: .init(url: nil, category: .mealVoucher),
            largeIcon: .init(url: nil, category: .mealVoucher))
        )
    }
}
