//
//  CompetitionsListViewModel.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import Foundation
import Combine
import FootballService

final class CompetitionsListViewModel: ObservableObject {
    @Published var selection: Int?
    @Published private(set) var competitions: [Competition] = []

    private let footballService: FootballService
    private var store = Set<AnyCancellable>()

    init(footballService: FootballService) {
        self.footballService = footballService
    }

    func load() {
        footballService.competitions()
            .receive(on: DispatchQueue.main)
            .sink { (_) in } receiveValue: { competitions in
                self.competitions = competitions
            }.store(in: &store)
    }
}
