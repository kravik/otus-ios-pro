//
//  CompetitionViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import Foundation
import Networking

final class CompetitionViewModel: ObservableObject {

    enum Segment: Int, CaseIterable {
        case teams, matches

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
    @Published var selectedSegment: Segment = .teams

    init(competition: Competition) {
        self.competition = competition
    }
}
