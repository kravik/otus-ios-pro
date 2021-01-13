//
//  CompetitionsListView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI
import Networking
import UIComponents

struct CompetitionsListView: View {
    @EnvironmentObject var viewModel: CompetitionsListViewModel
    @EnvironmentObject var navControllerViewModel: NavControllerViewModel

    var body: some View {
        List {
            ForEach(viewModel.competitions) { item in
                NavPushButton(destination: CompetitionView(viewModel: CompetitionViewModel(competition: item))) {
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

struct CompetitionsListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionsListView().environmentObject(CompetitionsListViewModel())
    }
}
