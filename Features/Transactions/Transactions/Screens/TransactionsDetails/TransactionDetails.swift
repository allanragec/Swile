//
//  TransactionDetailsView.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Components
import SwiftUI
import TransactionsAPI

enum DetailsScreenStep {
    case firstStep
    case secondStep
    case finished
}

import Foundation

final class DetailsScreenStepStateManager: ObservableObject {
    
    @MainActor @Published private(set) var state: DetailsScreenStep = .firstStep
    
    @MainActor func dismiss() {
        Task {
            state = .secondStep
            
            try? await Task.sleep(for: Duration.seconds(1))
            
            self.state = .finished
        }
    }
}

struct TransactionDetailsView: View {
    @ObservedObject var viewModel: TransactionDetailsViewModel
    @Binding var detailTransaction: TransactionsAPI.Transaction?
    let namespace: Namespace.ID
    
    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false // Mark 2
    
    init(
        _ transaction: TransactionsAPI.Transaction,
        detailTransaction: Binding<TransactionsAPI.Transaction?> = Binding.constant(nil),
        namespace: Namespace.ID
    ) {
        self.viewModel = .init(transaction)
        self._detailTransaction = detailTransaction
        self.namespace = namespace
    }
    
    func smallIconView() -> some View {
        return Group {
            Group {
                if let url = viewModel.transaction.smallIconURL {
                    ImageView(withURL: url)
                        .frame(width: 16, height: 16)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                else {
                    Image(viewModel.transaction.smallIconName)
                }
            }
            .frame(width: 22, height: 22)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-smallIconView", in: namespace)
        .frame(width: 66, height: 66, alignment: .bottomTrailing)
    }
    
    fileprivate func largeIcon() -> some View {
        return Group {
            Group {
                if let url = viewModel.transaction.largeIconURL {
                    ImageView(withURL: url)
                        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-ImageView", in: namespace)
                }
                else {
                    Image(viewModel.transaction.largeIconName)
                        .frame(width: 24, height: 24, alignment: .center)
                        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-image", in: namespace)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 224)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(viewModel.transaction.getBorderColor(), lineWidth: 0)
                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-RoundedRectangle", in: namespace)
        )
        .background(
            viewModel.transaction.getBackgroundColor()
                .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-background", in: namespace)
        )
    }
    
    func detailedView() -> some View {
        return VStack(spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                largeIcon()
                smallIconView()
                    .frame(alignment: .bottomTrailing)
                    .padding([.trailing], 12)
                    .padding([.bottom], -11)
            }
            
            Text(viewModel.price)
                .font(.custom("Segma-Bold", size: 34))
                .foregroundColor(Color(hex: 0x1D1148))
                .padding(.top, 24)
            
            Text(viewModel.title)
                .font(.custom("Segma-SemiBold", size: 13))
                .foregroundColor(Color(hex: 0x1D1148))
                .padding(.top, 4)
            
            Text(viewModel.subtitle)
                .font(.custom("Segma-Medium", size: 13))
                .foregroundColor(Color(hex: 0x918BA6))
                .padding(.top, 8)
            
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(.white)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            withAnimation(.spring(response: 0.8, dampingFraction: 1)) {
                self.detailTransaction = nil
            }
        }
    }
    
    var body: some View {
        return detailedView()
    }
}

struct TransactionDetails_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ForEach(
            ColorScheme.allCases,
            id: \.self,
            content:  TransactionDetailsView(.init(
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
                largeIcon: .init(url: nil, category: .computer)),
                                             namespace: namespace
            )
            .preferredColorScheme
        )
    }
}
