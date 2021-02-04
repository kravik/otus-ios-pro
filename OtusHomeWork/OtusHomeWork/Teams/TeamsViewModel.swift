//
//  File.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import Foundation
import Combine
import FootballService

final class TeamsViewModel: ObservableObject {
    let competition: Competition
    @Published private(set) var teams: [Team] = []
    @Published private(set) var isPageLoading: Bool = false

    private let footballService: FootballService
    private var store = Set<AnyCancellable>()

    init(footballService: FootballService, competition: Competition) {
        self.footballService = footballService
        self.competition = competition
    }

    func load() {
        isPageLoading = true
        footballService
            .teams(competition: competition)
            .receive(on: DispatchQueue.main)
            .sink { (_) in } receiveValue: { teams in
                self.teams.append(contentsOf: teams)
                self.isPageLoading = false
            }.store(in: &store)
    }
}
