//
//  MatchesView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 11.01.2021.
//

import SwiftUI
import Networking

struct MatchesView: View {
    @ObservedObject var viewModel: MatchesListViewModel

    var body: some View {
        List {
            ForEach(viewModel.matches) { item in
                MatchCell(item: item).onAppear {
                    if viewModel.matches.isLast(item) {
                        viewModel.loadNext()
                    }
                }
            }
        }.onAppear {
            viewModel.loadNext()
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
        VStack(alignment: .leading, spacing: 4) {
            Text("\(item.homeTeam?.name ?? "") - \(item.awayTeam?.name ?? "")")
                .font(.headline)
                .foregroundColor(.primary)
            Text("\(item.utcDate, formatter: Self.dateFormatter)")
                .font(.callout)
                .foregroundColor(.secondary)
        }
        .frame(minHeight: 60)
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {

    func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView(viewModel: .init(competition: .init(id: 1, name: "Italy", lastUpdated: Date(), plan: "TIER")))
    }
}
