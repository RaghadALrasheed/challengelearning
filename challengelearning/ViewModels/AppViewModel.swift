import SwiftUI
import Observation

@Observable
class AppViewModel {
    var goal: LearningGoal?

    var endDate: Date? {
        guard let goal else { return nil }
        return Calendar.current.date(byAdding: .day, value: goal.duration.totalDays, to: goal.startDate)
    }

    var isGoalFinished: Bool {
        guard let endDate else { return false }
        return Date() >= endDate
    }
    init() {
        load()
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "learningGoal"),
           let saved = try? JSONDecoder().decode(LearningGoal.self, from: data) {
            goal = saved
        }
    }
    func setGoal(_ newGoal: LearningGoal) {
        goal = newGoal
        if let data = try? JSONEncoder().encode(newGoal) {
            UserDefaults.standard.set(data, forKey: "learningGoal")
        }
    }
    func goalLogs() -> [DayLog] {
        guard let goal,
              let data = UserDefaults.standard.data(forKey: "dayLogs"),
              let all = try? JSONDecoder().decode([DayLog].self, from: data)
        else { return [] }

        return all.filter { $0.date >= goal.startDate }
    }
    var isStreakBroken: Bool {
        guard let goal else { return false }
        let lastActivity = goalLogs().map(\.date).max() ?? goal.startDate
        return Date().timeIntervalSince(lastActivity) > 32 * 60 * 60
    }
}
