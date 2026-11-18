import SwiftUI
import Observation

@Observable
class CalendarViewModel {
    var logs: [DayLog] = []

    init() {
        load()
    }
    func load() {
        logs = DayLog.loadAll()
    }

    func status(for date: Date) -> DayStatus? {
        logs.status(for: date)
    }

    var months: [Date] {
        let calendar = Calendar.current
        guard let startOfYear = calendar.dateInterval(of: .year, for: Date())?.start,
              let endOfYear = calendar.dateInterval(of: .year, for: Date())?.end
        else { return [] }

        let firstLog = logs.map(\.date).min() ?? startOfYear
        let firstDate = min(firstLog, startOfYear)
        guard let start = calendar.dateInterval(of: .month, for: firstDate)?.start else { return [] }

        var result: [Date] = []
        var current = start
        while current < endOfYear {
            result.append(current)
            current = calendar.date(byAdding: .month, value: 1, to: current)!
        }
        return result
    }
    func days(in month: Date) -> [Date?] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }

        let firstWeekday = calendar.component(.weekday, from: month)
        let blanks: [Date?] = Array(repeating: nil, count: firstWeekday - 1)

        let dates: [Date?] = range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: month)
        }
        return blanks + dates
    }
    var currentMonth: Date? {
        Calendar.current.dateInterval(of: .month, for: Date())?.start
    }
}
