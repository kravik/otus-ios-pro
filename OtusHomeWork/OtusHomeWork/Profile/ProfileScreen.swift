//
//  ProfileScreen.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 20.12.2020.
//

import SwiftUI

struct ProfileScreen: View {

    var body: some View {
        NavigationView {
            ProfileView()
        }
    }
}

struct ProfileView: View {
    @State var isModeOpen = false

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Username")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            Text("Profile info")
                .font(.body)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            Button("Open") {
                isModeOpen = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
            .sheet(isPresented: $isModeOpen, content: {
                Text("Modal View")
            })
        }
        .padding()
        .navigationTitle("Profile")
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
