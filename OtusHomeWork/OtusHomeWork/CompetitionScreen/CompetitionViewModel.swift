//
//  CompetitionViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import Foundation
import FootballService

final class CompetitionViewModel: ObservableObject {

    enum Segment: Int, CaseIterable {
        case matches, teams

        var name: String {
            switch self {
            case .teams:
                return "Teams"
            case .matches:
                return "Matches"
            }
        }
    }

    let competition: Competition
    @Published var selectedSegment: Segment = .matches

    init(competition: Competition) {
        self.competition = competition
    }
}
