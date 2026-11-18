import SwiftUI
import Observation

@Observable
class LearningGoalViewModel {
    var topic: String
    var duration: LearningDuration
    var showAlert = false

    private let appViewModel: AppViewModel

    init(appViewModel: AppViewModel) {
        self.appViewModel = appViewModel
        topic = appViewModel.goal?.goal ?? ""
        duration = appViewModel.goal?.duration ?? .week
    }

    var hasChanges: Bool {
        topic != appViewModel.goal?.goal || duration != appViewModel.goal?.duration
    }

    var needsConfirmation: Bool {
        appViewModel.goal != nil && !appViewModel.isGoalFinished && hasChanges
    }

    func saveGoal() {
        appViewModel.setGoal(LearningGoal(goal: topic, duration: duration, startDate: Date()))
    }
}
