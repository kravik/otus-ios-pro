//
//  TeamsView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI

struct TeamsView: View {
    @ObservedObject var teamsViewModel: TeamsViewModel

    var body: some View {
        List {
            ForEach(teamsViewModel.teams) { item in
                TeamCell(item: item)
            }
        }.onAppear {
            teamsViewModel.load()
        }.navigationTitle("Teams of \(teamsViewModel.competition.name)")
    }
}

struct TeamCell: View {
    let item: Team

    var body: some View {
        Text(item.name)
            .font(.headline)
            .foregroundColor(.primary).frame(minHeight: 60)
    }
}
