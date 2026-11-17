//
//  OnboardingView.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 02/06/1448 AH.
//

import SwiftUI
struct OnboardingView: View {
    @Binding var hasGoal: Bool
    @State private var duration: LearningDuration = .week
    @State private var topic = ""
    @State private var savedGoal: LearningGoal?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: "flame.fill")
                .foregroundStyle(.orange)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
                .padding(.bottom, 50)
            Text("Hello ")
                .font(.largeTitle)
           + Text("Learner")
                .font(.largeTitle)
                .bold()
            Text("This app will help you learn everyday!")
                .foregroundStyle(.secondary)
                .padding(.top, -12)
            Text("I want to learn")
                .padding(.top, 24)
            
            TextField("Swift", text: $topic)
                .font(.title3)
            Divider()
            Text("I want to learn it in a")
            HStack {
                ForEach(LearningDuration.allCases,id: \.self){item in Button (item.title) {
                    duration = item
                }
                .buttonStyle(.borderedProminent)
                .tint(duration == item ? .orange : .gray.opacity(0.3))
                }
            }
            Spacer()
            Button("Start Learning") {
                let goal = LearningGoal(goal: topic, duration: duration, startDate: Date())
                
                
                if let data = try? JSONEncoder().encode(goal) {
                    UserDefaults.standard.set(data, forKey: "learningGoal")
                    
                }
                hasGoal = true
            }
            .buttonStyle(.borderedProminent)
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
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: "learningGoal"),
               let goal = try? JSONDecoder().decode(LearningGoal.self, from: data) {
                savedGoal = goal
                print(goal)
            }
        }
        }
    }

#Preview {
    OnboardingView(hasGoal: .constant(false))
}
