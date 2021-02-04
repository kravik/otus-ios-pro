//
//  OtusHomeWorkApp.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 15.12.2020.
//

import SwiftUI
import FootballService

@main
struct OtusHomeWorkApp: App {

    let serviceLocator: ServiceLocator = {
        let serviceLocator = ServiceLocator()
        serviceLocator.register(FootballService())
        return serviceLocator
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(DependeciesContainer(serviceLocator: serviceLocator))
                .environmentObject(Router())
        }
    }
}
