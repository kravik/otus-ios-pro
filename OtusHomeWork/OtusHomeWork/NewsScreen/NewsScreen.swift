//
//  NewsScreen.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 16.12.2020.
//

import SwiftUI

struct NewsScreen: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var сompetitionsListViewModel: CompetitionsListViewModel

    var body: some View {
        VStack {
            Text("News").font(Font.headline)
            Button("Open Serie A") {
                router.selectedTab = .competitions
                сompetitionsListViewModel.selection = 2019
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
        }
        .padding()
    }
}
