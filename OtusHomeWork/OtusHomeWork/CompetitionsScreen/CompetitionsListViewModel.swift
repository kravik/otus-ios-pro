//
//  CompetitionsListViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import Foundation

final class CompetitionsListViewModel: ObservableObject {
    @Published var selection: Int?
    @Published private(set) var competitions: [Competition] = []

    func load() {
        competitions = FootballAPI.getCompetitions()
    }
}
