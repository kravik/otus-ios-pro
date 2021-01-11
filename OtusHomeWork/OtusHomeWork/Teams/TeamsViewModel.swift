//
//  File.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import Foundation
import Networking

final class TeamsViewModel: ObservableObject {
    let competition: Competition

    @Published private(set) var teams: [Team] = []
    @Published private(set) var isPageLoading: Bool = false

    init(competition: Competition) {
        self.competition = competition
    }

    func load() {
        isPageLoading = true
        FootballAPI.getTeamsAuthorized(competitionId: competition.id) { [weak self] response, error in
            guard let self = self, let results = response?.teams else {
                return
            }
            self.teams.append(contentsOf: results)
            self.isPageLoading = false
        }
    }
}
