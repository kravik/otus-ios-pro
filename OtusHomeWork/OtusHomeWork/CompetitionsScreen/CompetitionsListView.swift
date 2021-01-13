//
//  CompetitionsListView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI
import Networking

struct CompetitionsListView: View {
    @EnvironmentObject var viewModel: CompetitionsListViewModel

    var body: some View {
        List {
            ForEach(viewModel.competitions) { item in
                NavigationLink(
                    destination: CompetitionView(viewModel: CompetitionViewModel(competition: item)),
                    tag: item.id,
                    selection: $viewModel.selection
                ) {
                    CompetitionCell(item: item)
                }
            }
        }.onAppear {
            viewModel.load()
        }.navigationTitle("Competitions")
    }
}


struct CompetitionCell: View {
    let item: Competition

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary)
            Text(item.area?.name ?? "")
                .font(.callout)
                .foregroundColor(.secondary)
        }
        .frame(minHeight: 60)
    }
}

struct CompetitionsListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionsListView().environmentObject(CompetitionsListViewModel())
    }
}
