//
//  OtusHomeWorkApp.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 15.12.2020.
//

import SwiftUI

@main
struct OtusHomeWorkApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(Router())
                .environmentObject(CompetitionsListViewModel())
        }
    }
}
