//
//  TeamsScreen.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI

struct TeamsScreen: View {
    @ObservedObject var teamsViewModel: TeamsViewModel

    var body: some View {
        TeamsView(teamsViewModel: teamsViewModel)
    }
}
