import SwiftUI

struct CalendarView: View {
    @State private var viewModel = CalendarViewModel()

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.months, id: \.self) { month in
                        VStack(alignment: .leading, spacing: 12) {

                            Text(month.formatted(.dateTime.month(.wide).year()))
                                .font(.headline)

                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(weekdays, id: \.self) { day in
                                    Text(day)
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(.secondary)
                                }

                                ForEach(Array(viewModel.days(in: month).enumerated()), id: \.offset) { _, date in
                                    if let date {
                                        dayCell(date)
                                    } else {
                                        Color.clear.frame(height: 40)
                                    }
                                }
                            }

                            Divider()
                        }
                        .id(month)
                    }
                }
                .padding()
            }
            .onAppear {
                if let currentMonth = viewModel.currentMonth {
                    proxy.scrollTo(currentMonth, anchor: .top)
                }
            }
        }
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.load()
        }
    }

    private func dayCell(_ date: Date) -> some View {
        let status = viewModel.status(for: date)
        let isToday = Calendar.current.isDateInToday(date)

        return Text(date.formatted(.dateTime.day()))
            .font(.title3)
            .foregroundStyle(
                status == .learned ? Color.orange :
                status == .freezed ? Color.cyan :
                isToday ? Color.white : Color.primary
            )
            .frame(width: 40, height: 40)
            .background(
                status == .learned ? Color.orange.opacity(0.2) :
                status == .freezed ? Color.cyan.opacity(0.2) :
                isToday ? Color.orange : Color.clear,
                in: Circle()
            )
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
