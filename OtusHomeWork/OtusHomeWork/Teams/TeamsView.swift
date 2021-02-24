//
//  TeamsView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI
import FootballService
import UIComponents

struct TeamsView: View {
    @ObservedObject var teamsViewModel: TeamsViewModel

    var body: some View {
        List {
            ForEach(teamsViewModel.teams) { item in
                NavPushButton(destination: TeamView(team: item)) {
                    TeamCell(item: item)
                }
            }
        }.onAppear {
            teamsViewModel.load()
        }
    }
}

struct TeamCell: View {
    let item: Team

    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary).frame(minHeight: 60)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}
