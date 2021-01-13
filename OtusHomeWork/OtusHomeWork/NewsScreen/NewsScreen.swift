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
        }
        .padding()
    }
}
