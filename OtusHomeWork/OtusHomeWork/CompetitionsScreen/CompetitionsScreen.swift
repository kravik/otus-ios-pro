//
//  CompetitionsScreen.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 16.12.2020.
//

import SwiftUI

struct CompetitionsScreen: View {

    @EnvironmentObject var competitionsListViewModel: CompetitionsListViewModel

    var body: some View {
        NavigationView {
            CompetitionsListView()
        }
    }
}
