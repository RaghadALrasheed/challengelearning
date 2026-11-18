import SwiftUI

struct GoalResultView: View {
    var appViewModel: AppViewModel
    @State private var viewModel: GoalResultViewModel

    init(appViewModel: AppViewModel, goal: LearningGoal, logs: [DayLog]) {
        self.appViewModel = appViewModel
        _viewModel = State(initialValue: GoalResultViewModel(goal: goal, logs: logs))
    }

    var body: some View {
        VStack(spacing: 12) {

            Image(systemName: viewModel.isGoalReached ? "hands.clap.fill" : "xmark.seal")
                .font(.system(size: 50))
                .foregroundStyle(.orange)

            Text(viewModel.isGoalReached ? "Well done!" : "You didn't reach your goal this time.")
                .font(.headline)
                .bold()

            Text(viewModel.isGoalReached ? "Ready for your next goal?" : "Want to set another goal?")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            NavigationLink {
                LearningGoalView(appViewModel: appViewModel)
            } label: {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .glassEffect(.regular.tint(.orange), in: Capsule())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        GoalResultView(
            appViewModel: AppViewModel(),
            goal: LearningGoal(goal: "Swift", duration: .week, startDate: Date()),
            logs: []
        )
    }
}
