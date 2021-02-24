//
//  MatchesListViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import Foundation
import Combine
import FootballService

final class MatchesListViewModel: ObservableObject {
    @Published private(set) var matches: [Match] = []
    @Published private(set) var isPageLoading: Bool = false

    private let footballService: FootballService
    private let competition: Competition
    private var store = Set<AnyCancellable>()
    private var matchday = 0

    init(footballService: FootballService, competition: Competition) {
        self.footballService = footballService
        self.competition = competition
    }

    func loadNext() {
        guard isPageLoading == false else {
            return
        }
        matchday += 1
        isPageLoading = true
        footballService
            .matches(competition: competition, matchday: matchday)
            .receive(on: DispatchQueue.main)
            .sink { (_) in } receiveValue: { matches in
                self.matches.append(contentsOf: matches)
                self.isPageLoading = false
            }.store(in: &store)
    }
}
