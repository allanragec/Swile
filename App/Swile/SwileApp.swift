//
//  SwileApp.swift
//  Swile
//
//  Created by Allan Melo on 30/04/23.
//

import SwiftUI
import Transactions

@main
struct SwileApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TransactionsListView()
        }
    }
}
