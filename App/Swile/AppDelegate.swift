//
//  AppDelegate.swift
//  Swile
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DependenciesInjection.registerDependencies()
        return true
    }
}
