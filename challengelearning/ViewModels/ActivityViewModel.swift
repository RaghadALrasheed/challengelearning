import SwiftUI
import Observation

@Observable
class ActivityViewModel {
    var logs: [DayLog] = []

    let maxFreezes = LearningDuration.week.maxFreezes

    var todayStatus: DayStatus? {
        status(for: Date())
    }

    var learnedCount: Int {
        logs.filter { $0.status == .learned }.count
    }

    var freezedCount: Int {
        logs.filter { $0.status == .freezed }.count
    }

    func status(for date: Date) -> DayStatus? {
        logs.first { Calendar.current.isDate($0.date, inSameDayAs: date) }?.status
    }

    func toggleLearned() {
        let old = todayStatus
        logs.removeAll { Calendar.current.isDateInToday($0.date) }
        if old != .learned {
            logs.append(DayLog(date: Date(), status: .learned))
        }
    }

    func toggleFreeze() {
        let old = todayStatus
        logs.removeAll { Calendar.current.isDateInToday($0.date) }
        if old != .freezed {
            logs.append(DayLog(date: Date(), status: .freezed))
        }
    }
}
