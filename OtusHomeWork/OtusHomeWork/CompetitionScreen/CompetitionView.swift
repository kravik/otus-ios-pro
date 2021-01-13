//
//  CompetitionView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import SwiftUI

struct CompetitionView: View {
    @ObservedObject var viewModel: CompetitionViewModel

    private let teamsViewModel: TeamsViewModel
    private let matchesViewModel: MatchesListViewModel

    init(viewModel: CompetitionViewModel) {
        self.viewModel = viewModel
        self.teamsViewModel = .init(competition: viewModel.competition)
        self.matchesViewModel = .init(competition: viewModel.competition)
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
        }.navigationTitle(viewModel.competition.name)
    }
}

struct CompetitionView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionView(viewModel: CompetitionViewModel(competition: .init(id: 1, name: "Italy", lastUpdated: Date(), plan: "TIER")))
    }
}
