//
//  File.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import Foundation

final class TeamsViewModel: ObservableObject {
    let competition: Competition

    @Published private(set) var teams: [Team] = []

    init(competition: Competition) {
        self.competition = competition
    }

    func load() {
        teams = FootballAPI.getTeams(for: competition)
    }
}
