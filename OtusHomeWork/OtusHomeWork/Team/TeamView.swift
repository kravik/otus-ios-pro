//
//  TeamView.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 14.01.2021.
//

import SwiftUI
import Networking
import UIComponents

struct TeamView: View {
    let team: Team
    @EnvironmentObject var navControllerViewModel: NavControllerViewModel
    @State var isAtMaxScale = false
    @State var isAtMaxRotation = false

    private let animation = Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)
    private let maxScale: CGFloat = 1.2

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(team.name)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.purple, .orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .mask(
                    RoundedRectangle(cornerRadius: 16)
                )
                .scaleEffect(isAtMaxScale ? maxScale : 1)
            Spacer()
            Image(systemName: "sportscourt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 64.0, height: 64.0)
                .foregroundColor(Color.green)
                .rotationEffect(isAtMaxRotation ? Angle(radians: .pi / 4)  : Angle(radians: -.pi / 4))
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .onAppear() {
            navControllerViewModel.navigationTitle = "Team"
            withAnimation(animation) {
                isAtMaxScale.toggle()
                isAtMaxRotation.toggle()
            }
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: Team(id: 1, name: "Team 1"))
    }
}
