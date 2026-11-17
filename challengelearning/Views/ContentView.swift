//
//  ContentView.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 01/06/1448 AH.
//

import SwiftUI


struct ContentView: View {
    @State private var hasGoal = false

    var body: some View {
        Group {
            if hasGoal {
                ActivityView()
            } else {
                OnboardingView(hasGoal: $hasGoal)
            }
        }
        .onAppear {
            hasGoal = UserDefaults.standard.data(forKey: "learningGoal") != nil
        }
    }
}
#Preview {
    ContentView()
}
