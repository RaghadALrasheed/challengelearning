import Foundation

struct DayLog: Codable {
    var date: Date
    var status: DayStatus
}

// MARK: - Storage

extension DayLog {
    private static let storageKey = "dayLogs"

    static func loadAll() -> [DayLog] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let logs = try? JSONDecoder().decode([DayLog].self, from: data)
        else { return [] }
        return logs
    }

    static func saveAll(_ logs: [DayLog]) {
        if let data = try? JSONEncoder().encode(logs) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}

// MARK: - Queries

extension Array where Element == DayLog {
    func status(for date: Date) -> DayStatus? {
        first { Calendar.current.isDate($0.date, inSameDayAs: date) }?.status
    }

    var learnedCount: Int {
        filter { $0.status == .learned }.count
    }

    var freezedCount: Int {
        filter { $0.status == .freezed }.count
    }
}
