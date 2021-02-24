//
//  DependeciesContainer.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 03.02.2021.
//

import Foundation
import FootballService

final class DependeciesContainer: ObservableObject {

    let serviceLocator: ServiceLocator

    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }

    func makeCompetitionsListViewModel() -> CompetitionsListViewModel {
        CompetitionsListViewModel(footballService: serviceLocator.service())
    }

    func makeMatchesListViewModel(competition: Competition) -> MatchesListViewModel {
        MatchesListViewModel(footballService: serviceLocator.service(), competition: competition)
    }

    func makeTeamsListViewModel(competition: Competition) -> TeamsViewModel {
        TeamsViewModel(footballService: serviceLocator.service(), competition: competition)
    }
}
