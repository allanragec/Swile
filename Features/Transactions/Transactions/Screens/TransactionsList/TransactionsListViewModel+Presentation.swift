//
//  TransactionsListViewModel+Presentation.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

extension TransactionsListViewModel {
    var title: String { "Titres-resto" }
    var loadingTransactionsTitle: String { "Chargement des opérations"}
    var somethingWrongTitle: String { "Quelque chose s'est mal passé" }
    var couldNotRefreshTransactionsMessage: String { "Impossible d'actualiser les transactions" }
    var couldNotLoadTransactionsMessage: String { "Impossible de charger les transactions" }
}
