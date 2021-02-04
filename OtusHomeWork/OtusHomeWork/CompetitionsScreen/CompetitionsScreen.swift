//
//  CompetitionsScreen.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 16.12.2020.
//

import SwiftUI
import UIComponents

struct CompetitionsScreen: View {

    let dependeciesContainer: DependeciesContainer

    var body: some View {
        NavControllerView(transition: .custom(.moveAndFade)) {
            CompetitionsListView(dependeciesContainer: dependeciesContainer)
        }
    }
}
