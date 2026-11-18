//
//  OnboardingView.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 02/06/1448 AH.
//

import SwiftUI

struct OnboardingView: View {
    var appViewModel: AppViewModel
    @State private var duration: LearningDuration = .week
    @State private var topic = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: "flame.fill")
                .foregroundStyle(.orange)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
                .padding(.bottom, 50)

            Text("Hello \(Text("Learner").bold())")
                .font(.largeTitle)

            Text("This app will help you learn everyday!")
                .foregroundStyle(.secondary)
                .padding(.top, -12)

            Text("I want to learn")
                .padding(.top, 24)

            TextField("Swift", text: $topic)
                .font(.title3)

            Divider()

            Text("I want to learn it in a")

            DurationPicker(selection: $duration)

            Spacer()

            Button("Start Learning") {
                let goal = LearningGoal(goal: topic, duration: duration, startDate: Date())
                appViewModel.setGoal(goal)
            }
            .buttonStyle(.glassProminent)
            .tint(.orange)
            .frame(maxWidth: .infinity)
            .controlSize(.large)

            Text("You can edit your desire later")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    OnboardingView(appViewModel: AppViewModel())
}
