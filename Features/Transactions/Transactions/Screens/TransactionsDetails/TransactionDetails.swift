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

public final class DetailsScreenStepStateManager: ObservableObject {
    @MainActor @Published var state: DetailsScreenStep = .firstStep
    
    public init() {}
    
    @MainActor func setup() {
        state = .firstStep
    }
}

struct TransactionDetailsView: View {
    @StateObject var viewModel: TransactionDetailsViewModel
    @Binding var detailTransaction: TransactionsAPI.Transaction?
    @State var dismissed: Bool = false
    @Binding var canStartNewAnimation: Bool
    let namespace: Namespace.ID
    
    @EnvironmentObject private var screenState: DetailsScreenStepStateManager
    
    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    
    private let animationTimer = Timer
        .publish(every: 0.6, on: .current, in: .common)
        .autoconnect()
    
    init(
        _ transaction: TransactionsAPI.Transaction,
        detailTransaction: Binding<TransactionsAPI.Transaction?> = Binding.constant(nil),
        canStartNewAnimation: Binding<Bool> = Binding.constant(false),
        namespace: Namespace.ID
    ) {
        let viewModel = TransactionDetailsViewModel(transaction)
        _viewModel = StateObject(wrappedValue: viewModel)
        self._detailTransaction = detailTransaction
        self._canStartNewAnimation = canStartNewAnimation
        self.namespace = namespace
    }
    
    func smallIconView() -> some View {
        return Group {
            Group {
                if let image = viewModel.smallImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
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
            if let image = viewModel.largeImage {
                if viewModel.isLargeImageResized {
                    Image(uiImage: image)
                        .resizable()
                        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-image", in: namespace)
                        .frame(width: 57, height: 57)
                    
                }
                else {
                    Image(uiImage: image)
                        .resizable()
                        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-image", in: namespace)
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 224)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(viewModel.transaction.getBorderColor(), lineWidth: 0)
                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-RoundedRectangle", in: namespace)
        )
        .background(
            (viewModel.transaction.getBackgroundColor())
                .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-background", in: namespace)
        )
    }
    
    var detailsHeaderView: some View {
        VStack(spacing: 0) {
            if firstAnimation {
                Text(viewModel.price)
                    .font(.custom("Segma-Bold", size: 34))
                    .foregroundColor(Color(hex: 0x1D1148))
                    .padding(.top, 24)
                    .opacity(1)
                    .matchedGeometryEffect(id: "details-price", in: namespace)
                
                Text(viewModel.title)
                    .font(.custom("Segma-SemiBold", size: 13))
                    .foregroundColor(Color(hex: 0x1D1148))
                    .padding(.top, 4)
                    .opacity(1)
                    .matchedGeometryEffect(id: "details-title", in: namespace)
                
                Text(viewModel.subtitle)
                    .font(.custom("Segma-Medium", size: 13))
                    .foregroundColor(Color(hex: 0x918BA6))
                    .padding(.top, 8)
                    .opacity(1)
                    .matchedGeometryEffect(id: "details-subtitle", in: namespace)
            }
            else {
                Text(viewModel.price)
                    .font(.custom("Segma-Bold", size: 34))
                    .foregroundColor(Color(hex: 0x1D1148))
                    .padding(.top, 100)
                    .opacity(0)
                    .matchedGeometryEffect(id: "details-price", in: namespace)
                
                
                Text(viewModel.title)
                    .font(.custom("Segma-SemiBold", size: 13))
                    .foregroundColor(Color(hex: 0x1D1148))
                    .padding(.top, 4)
                    .opacity(0)
                    .matchedGeometryEffect(id: "details-title", in: namespace)
                
                Text(viewModel.subtitle)
                    .font(.custom("Segma-Medium", size: 13))
                    .foregroundColor(Color(hex: 0x918BA6))
                    .padding(.top, 8)
                    .opacity(0)
                    .matchedGeometryEffect(id: "details-subtitle", in: namespace)
            }
        }
    }
    
    struct OptionItem: Identifiable {
        var id: Int { title.hashValue }
        let image: String
        let backgroundColor: Color
        let borderColor: Color
        let title: String
        let hasChangeAccount: Bool
        
        public init(
            image: String,
            backgroundColor: Color = Color(hex: 0xF6F6F8),
            borderColor: Color = Color(hex: 0xEEEDF1),
            title: String,
            hasChangeAccount: Bool = false
        ) {
            self.image = image
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.title = title
            self.hasChangeAccount = hasChangeAccount
        }
    }
    var options: [OptionItem] = [
        .init(
            image: "icon_medium_meal_voucher",
            backgroundColor: Color(hex: 0xFFEBD4),
            borderColor: Color(hex: 0xFD9B28, alpha: 0.06),
            title: "Titres-resto",
            hasChangeAccount: true
        ),
        .init(image: "icon_medium_share",
              title: "Partage d’addition"
             ),
        .init(
            image: "icon_medium_heart",
            title: "Aimer"
        ),
        .init(
            image: "icon_medium_help",
            title: "Signaler un problème"
        )
    ]
    
    func iconView(_ option: OptionItem) -> some View {
        Group {
                Image(option.image)
                        .frame(width: 20, height: 20, alignment: .center)
        }
        .frame(width: 32, height: 32)
        .clipShape(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(option.borderColor, lineWidth: 1)
//                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-RoundedRectangle", in: namespace)
        )
        .background(
            option.backgroundColor
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                .matchedGeometryEffect(id: "\(viewModel.transaction.name)-background", in: namespace)
        )
//        .matchedGeometryEffect(id: "\(viewModel.transaction.name)-image", in: namespace)
    }
    
    var optionsListView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<options.count, id: \.self) { index in
                HStack(spacing: 0) {
                    iconView(options[index])
                    
                    Text(options[index].title)
                        .font(.custom("Segma-Medium", size: 15))
                        .foregroundColor(Color(hex: 0x1D1148))
                        .padding(.leading, 12)
                    
                    Spacer()
                    
                    if options[index].hasChangeAccount {
                        Text("Changer \nde compte")
                            .frame(alignment: .trailing)
                            .font(.custom("Segma-SemiBold", size: 12))
                            .foregroundColor(Color(hex: 0x633FD3))
                            .multilineTextAlignment(.trailing)
                    }
                }
                .frame(height: 56)
                if index != (options.count - 1) {
                    Divider()
                }
            }
        }
    }
    
    var optionsView: some View {
        Group {
            if secondAnimation {
                optionsListView
                    .padding(.top, 24)
                    .opacity(1)
                    .matchedGeometryEffect(id: "optionsView", in: namespace)
            }
            else {
                if dismissed {
                    optionsListView
                        .padding(.top, 24)
                        .opacity(0)
                        .matchedGeometryEffect(id: "optionsView", in: namespace)
                }
                else {
                    optionsListView
                        .padding(.top, 100)
                        .opacity(0)
                        .matchedGeometryEffect(id: "optionsView", in: namespace)
                }
            }
        }
    }
    
    func detailedView() -> some View {
        return VStack(spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                largeIcon()
                
                smallIconView()
                    .frame(alignment: .bottomTrailing)
                    .padding([.trailing], 12)
                    .padding([.bottom], -11)
                
                ZStack {
                    if firstAnimation {
                        Image("icon_close")
                            .frame(width: 24, height: 24, alignment: .topLeading)
                            .padding([.leading], 20)
                            .padding([.top], 53)
                            .onTapGesture {
                                self.dismissed = true
                            }
                            .opacity(dismissed ? 0 : 1)
                            .matchedGeometryEffect(id: "icon_close", in: namespace)
                    }
                    else {
                        Image("icon_close")
                            .frame(width: 24, height: 24, alignment: .topLeading)
                            .padding([.leading], 20)
                            .padding([.top], 53)
                            .onTapGesture {
                                self.dismissed = true
                            }
                            .opacity(0)
                            .matchedGeometryEffect(id: "icon_close", in: namespace)
                    }
                  
                }
                .frame(width: UIScreen.main.bounds.width, height: 224, alignment: .topLeading)
                
            }
            
            detailsHeaderView
            
            optionsView
                .padding([.leading, .trailing], 20)
            
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(.white)
        .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
        return detailedView()
            .onReceive(animationTimer) { timerValue in
                updateAnimation()
            }
            .onAppear {
                self.canStartNewAnimation = false
            }
            .environmentObject(DetailsScreenStepStateManager())
    }
    
    private func updateAnimation() {
        if dismissed {
            switch screenState.state {
            case .firstStep:
                guard self.detailTransaction != nil else { return }
                animationTimer.upstream.connect().cancel()
                withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                    self.detailTransaction = nil
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                        self.canStartNewAnimation = true
                    }
                }
            case .secondStep:
                withAnimation(.easeIn(duration: 0.4)) {
                    self.firstAnimation = false
                    screenState.state = .firstStep
                }
            case .finished:
                withAnimation(.easeIn(duration: 0.6)) {
                    self.secondAnimation = false
                    screenState.state = .secondStep
                }
                break
            }
        }
        else {
            switch screenState.state {
            case .firstStep:
                withAnimation(.spring(response: 0.6)) {
                    firstAnimation = true
                    screenState.state = .secondStep
                }
            case .secondStep:
                if secondAnimation == false {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        self.secondAnimation = true
                        screenState.state = .finished
                    }
                }
            case .finished:
                break
            }
        }
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
