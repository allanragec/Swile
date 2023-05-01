//
//  DependencyOrchestrator.swift
//  DependencyOrchestrator
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public class DependencyOrchestrator {
    public static let shared: DependencyOrchestrator = .init()

    private init() {}
    private var bag: [String: (type: Any.Type, resolver: () -> (Any))] = .init()

    public func safelyResolve<Dependency>() -> Dependency? {
        return bag[String(reflecting: Dependency.self)]?.resolver() as? Dependency
    }

    public func resolve<Dependency>() -> Dependency {
        guard let dependency: Dependency = safelyResolve() else {
            fatalError("Could not resolve the dependency \(Dependency.self)")
        }

        return dependency
    }

    public static func whenFindProtocol<Dependency>(_ type: Dependency.Type, returns: @escaping () -> (Dependency)) {
        if let _ : Dependency = shared.safelyResolve() {
            fatalError("Dependency \(String(reflecting: type)) is already registered")
        }
        shared.bag[String(reflecting: type)] = (type, returns)
    }
}
