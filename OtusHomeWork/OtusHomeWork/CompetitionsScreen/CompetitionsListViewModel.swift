//
//  CompetitionsListViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import Foundation
import Networking

final class CompetitionsListViewModel: ObservableObject {
    @Published var selection: Int?
    @Published private(set) var competitions: [Competition] = []

    func load() {
        FootballAPI.getCompetitions(areas: nil, plan: "TIER_ONE") { [weak self] (response, error) in
            guard let self = self, let competitions = response?.competitions else {
                return
            }
            self.competitions = competitions
        }
    }
}
