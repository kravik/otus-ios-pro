//
//  MatchView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 13.01.2021.
//

import SwiftUI
import Networking
import UIComponents

struct MatchView: View {
    let match: Match
    @EnvironmentObject var navControllerViewModel: NavControllerViewModel

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("\(match.utcDate, formatter: Self.dateFormatter)")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack {
                Text("\(match.homeTeam?.name ?? "")")
                    .font(.headline)
                    .foregroundColor(.primary)
                if let result = match.score?.fullTime {
                    Text("\(result.homeTeam ?? 0) - \(result.awayTeam ?? 0)")
                        .font(.body)
                        .bold()
                        .padding()
                        .lineLimit(1)
                        .background(Color.red)
                }
                Text("\(match.awayTeam?.name ?? "")")
                    .font(.headline)
                    .foregroundColor(.primary)

            }
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .onAppear() {
            navControllerViewModel.navigationTitle = "Match"
        }
    }
}
