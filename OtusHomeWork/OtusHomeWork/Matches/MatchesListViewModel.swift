//
//  MatchesListViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import Foundation
import Networking

final class MatchesListViewModel: ObservableObject {
    let competition: Competition

    @Published private(set) var matches: [Match] = []
    @Published private(set) var isPageLoading: Bool = false

    private var matchday = 0

    init(competition: Competition) {
        self.competition = competition
    }

    func loadNext() {
        guard isPageLoading == false else {
            return
        }
        matchday += 1
        isPageLoading = true
        FootballAPI.getMatchesAuthorized(
            competitionId: competition.id,
            dateFrom: nil,
            dateTo: nil,
            stage: nil,
            status: nil,
            matchday: matchday
        ) { [weak self] response, error in
            guard let self = self, let results = response?.matches else {
                return
            }
            self.matches.append(contentsOf: results)
            self.isPageLoading = false
        }
    }
}
