//
//  CompetitionView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import SwiftUI
import UIComponents
import FootballService

struct CompetitionView: View {
    @ObservedObject var viewModel: CompetitionViewModel
    @EnvironmentObject var navControllerViewModel: NavControllerViewModel

    private let matchesViewModel: MatchesListViewModel
    private let teamsViewModel: TeamsViewModel

    init(competition: Competition, dependeciesContainer: DependeciesContainer) {
        self.viewModel = CompetitionViewModel(competition: competition)
        self.teamsViewModel = dependeciesContainer.makeTeamsListViewModel(competition: competition)
        self.matchesViewModel = dependeciesContainer.makeMatchesListViewModel(competition: competition)
    }

    var body: some View {
        VStack {
            Picker(
                selection: $viewModel.selectedSegment,
                label: EmptyView()
            ) {
                ForEach(CompetitionViewModel.Segment.allCases, id: \.self) { value in
                    Text(value.name).tag(value)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            switch viewModel.selectedSegment {
            case .teams:
                TeamsView(teamsViewModel: teamsViewModel)
            case .matches:
                MatchesView(viewModel: matchesViewModel)
            }
        }.onAppear() {
            navControllerViewModel.navigationTitle = viewModel.competition.name
            teamsViewModel.load()
            matchesViewModel.loadNext()
        }
    }
}
