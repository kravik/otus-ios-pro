//
//  CompetitionsListView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI
import FootballService
import UIComponents

struct CompetitionsListView: View {
    @EnvironmentObject var navControllerViewModel: NavControllerViewModel
    @ObservedObject var viewModel: CompetitionsListViewModel

    private let dependeciesContainer: DependeciesContainer

    init(dependeciesContainer: DependeciesContainer) {
        self.dependeciesContainer = dependeciesContainer
        self.viewModel = dependeciesContainer.makeCompetitionsListViewModel()
    }

    var body: some View {
        List {
            ForEach(viewModel.competitions) { item in
                NavPushButton(
                    destination: CompetitionView(
                        competition: item,
                        dependeciesContainer: dependeciesContainer
                    )
                ) {
                    CompetitionCell(item: item)
                }
            }
        }.onAppear {
            viewModel.load()
            navControllerViewModel.navigationTitle = "Competitions"
        }
    }
}


struct CompetitionCell: View {
    let item: Competition

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(Color.black)
                Text(item.area?.name ?? "")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity, minHeight: 60)
    }
}
