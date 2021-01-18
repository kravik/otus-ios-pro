//
//  ContentView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 15.12.2020.
//

import SwiftUI

final class Router: ObservableObject {

    enum Tab {
        case news, competitions, profile
    }

    @Published var selectedTab: Tab = .competitions
}

struct RootView: View {

    @EnvironmentObject var router: Router

    var body: some View {
        TabView(selection: $router.selectedTab) {
            let selection = router.selectedTab
            NewsScreen().tabItem {
                Image(systemName: selection == Router.Tab.news ? "newspaper.fill" : "newspaper")
                Text("News")
            }.tag(Router.Tab.news)
            CompetitionsScreen().tabItem {
                Image(systemName: selection == Router.Tab.competitions ? "star.fill" : "star")
                Text("Competitions")
            }.tag(Router.Tab.competitions)
            ProfileScreen().tabItem {
                Image(systemName: selection == Router.Tab.profile ? "person.fill" : "person")
                Text("Profile")
            }.tag(Router.Tab.profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(Router())
    }
}
