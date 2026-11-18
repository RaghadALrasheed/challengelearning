import SwiftUI
import Observation

@Observable
class ActivityViewModel {
    var logs: [DayLog] = []
    var startDate: Date = .distantPast

    var currentLogs: [DayLog] {
        logs.filter { $0.date >= startDate }
    }
    var duration: LearningDuration = .week

    var maxFreezes: Int {
        duration.maxFreezes
    }
    
    init() {
        load()
    }

    var todayStatus: DayStatus? {
        status(for: Date())
    }

    var learnedCount: Int {
        currentLogs.filter { $0.status == .learned }.count
    }

    var freezedCount: Int {
        currentLogs.filter { $0.status == .freezed }.count
    }

    func status(for date: Date) -> DayStatus? {
        currentLogs.first { Calendar.current.isDate($0.date, inSameDayAs: date) }?.status
    }

    func toggleLearned() {
        let old = todayStatus
        logs.removeAll { Calendar.current.isDateInToday($0.date) }
        if old != .learned {
            logs.append(DayLog(date: Date(), status: .learned))
        }
        save()
    }

    func toggleFreeze() {
        let old = todayStatus
        logs.removeAll { Calendar.current.isDateInToday($0.date) }
        if old != .freezed {
            logs.append(DayLog(date: Date(), status: .freezed))
        }
        save()
    }
    private func save() {
        if let data = try? JSONEncoder().encode(logs) {
            UserDefaults.standard.set(data, forKey: "dayLogs")
        }
    }
    private func load() {
        if let data = UserDefaults.standard.data(forKey: "dayLogs"),
           let saved = try? JSONDecoder().decode([DayLog].self, from: data) {
            logs = saved
        }
    }
    var weekDays: [Date] {
        let calendar = Calendar.current
        guard let start = calendar.dateInterval(of: .weekOfYear, for: Date())?.start else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    var isFreezeDisabled: Bool {
        todayStatus != .freezed && freezedCount >= maxFreezes
    }
}
