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
    @StateObject var viewModel: TransactionItemViewModel
    @Binding var detailTransaction: TransactionsAPI.Transaction?
    let namespace: Namespace.ID
    
    init(
        _ transaction: TransactionsAPI.Transaction,
        detailTransaction: Binding<TransactionsAPI.Transaction?> = Binding.constant(nil),
        namespace: Namespace.ID
    ) {
        let viewModel = TransactionItemViewModel(transaction)
        _viewModel = StateObject(wrappedValue: viewModel)
        self._detailTransaction = detailTransaction
        self.namespace = namespace
    }
    
    fileprivate func transactionCell() -> some View {
        return ZStack(alignment: .bottomLeading) {
            if detailTransaction == nil {
                TransactionItemImageView(viewModel.transaction, namespace: namespace)
            }
            
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
            .padding(.leading, 76)
            .frame(height: 66)
        }
    }
    
    var body: some View {
        transactionCell()
            .background(.white)
            .padding([.leading, .trailing], 20)
    }
}

struct TransactionItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    
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
            largeIcon: .init(url: nil, category: .mealVoucher)),
                            namespace: namespace)
    }
}
