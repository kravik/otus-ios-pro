//
//  MatchesView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import SwiftUI
import FootballService
import UIComponents

struct MatchesView: View {
    @ObservedObject var viewModel: MatchesListViewModel

    var body: some View {
        List {
            ForEach(viewModel.matches) { item in
                NavPushButton(destination: MatchView(match: item)) {
                    MatchCell(item: item).onAppear {
                        if viewModel.matches.isLast(item) {
                            viewModel.loadNext()
                        }
                    }
                }
            }
        }
    }
}

struct MatchCell: View {
    let item: Match

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(item.homeTeam?.name ?? "") - \(item.awayTeam?.name ?? "")")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(item.utcDate, formatter: Self.dateFormatter)")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .frame(minHeight: 60)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}
