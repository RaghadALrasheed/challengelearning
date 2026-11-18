//
//  ContentView.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 01/06/1448 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var appViewModel = AppViewModel()

    var body: some View {
        if appViewModel.goal != nil {
            NavigationStack {
                ActivityView(appViewModel: appViewModel)
            }
        } else {
            OnboardingView(appViewModel: appViewModel)
        }
    }
}

#Preview {
    ContentView()
}
