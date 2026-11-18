import SwiftUI
import Observation

@Observable
class GoalResultViewModel {
    let goal: LearningGoal
    let logs: [DayLog]

    init(goal: LearningGoal, logs: [DayLog]) {
        self.goal = goal
        self.logs = logs
    }
    var learnedCount: Int {
        logs.filter { $0.status == .learned }.count
    }
    var requiredLearned: Int {
        goal.duration.totalDays - goal.duration.maxFreezes
    }

    var isGoalReached: Bool {
        learnedCount >= requiredLearned
    }
}
