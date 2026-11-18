//
//  ActivityView.swift
//  challengelearning
//

import SwiftUI

struct ActivityView: View {
    var appViewModel: AppViewModel
    @State private var viewModel = ActivityViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            weekStrip
            statCards

            if appViewModel.isGoalFinished || appViewModel.isStreakBroken, let goal = appViewModel.goal {
                Spacer()
                GoalResultView(appViewModel: appViewModel, goal: goal, logs: appViewModel.goalLogs())
                Spacer()
            } else {
                Spacer()
                learnedButton
                Spacer()
                freezeButton
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal)
        .onAppear {
            viewModel.startDate = appViewModel.goal?.startDate ?? .distantPast
            viewModel.duration = appViewModel.goal?.duration ?? .week
        }
        .onChange(of: appViewModel.goal?.startDate) { _, newDate in
            viewModel.startDate = newDate ?? .distantPast
            viewModel.duration = appViewModel.goal?.duration ?? .week
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Activity")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                NavigationLink {
                    CalendarView()
                } label: {
                    circleIcon("calendar")
                }
                .buttonStyle(.plain)

                NavigationLink {
                    LearningGoalView(appViewModel: appViewModel)
                } label: {
                    circleIcon("pencil.and.outline")
                }
                .buttonStyle(.plain)
            }

            Text(Date().formatted(.dateTime.weekday(.wide).day().month(.wide)))
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 24)
    }

    // MARK: - Week Strip

    private var weekStrip: some View {
        HStack {
            ForEach(viewModel.weekDays, id: \.self) { date in
                let status = viewModel.status(for: date)

                VStack(spacing: 8) {
                    Text(date.formatted(.dateTime.weekday(.narrow)))
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.primary)
                    Text(date.formatted(.dateTime.day()))
                        .font(.title3)
                        .frame(width: 40, height: 40)
                        .background(
                            status == .learned ? Color.orange.opacity(0.3) :
                            status == .freezed ? Color.cyan.opacity(0.3) :
                            Calendar.current.isDateInToday(date) ? Color.orange : Color.clear,
                            in: Circle()
                        )
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Stat Cards

    private var statCards: some View {
        HStack(spacing: 12) {
            statCard(icon: "flame.fill", color: .orange, count: viewModel.learnedCount, label: "Learned")
            statCard(icon: "snowflake", color: .cyan, count: viewModel.freezedCount, label: "Freezed")
        }
    }

    private func statCard(icon: String, color: Color, count: Int, label: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            Text("\(count) \(count == 1 ? "day" : "days")")
                .font(.headline)
            Text(label)
                .font(.footnote)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .glassEffect(.regular.tint(.black.opacity(0.6)), in: RoundedRectangle(cornerRadius: 28))
    }

    // MARK: - Buttons

    private var learnedButton: some View {
        Button {
            viewModel.toggleLearned()
        } label: {
            Text(viewModel.todayStatus == .learned ? "Logged as Learned" : "Log as Learned")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 280, height: 280)
                .glassEffect(.regular.tint(viewModel.todayStatus == .learned ? .gray.opacity(0.3) : .orange), in: Circle())
        }
        .frame(maxWidth: .infinity)
    }

    private var freezeButton: some View {
        VStack(spacing: 16) {
            Button {
                viewModel.toggleFreeze()
            } label: {
                Text(viewModel.todayStatus == .freezed ? "Freezed for a day" : "Freeze for a day")
                    .foregroundStyle(.white)
                    .frame(width: 280)
                    .padding(.vertical, 12)
                    .glassEffect(.regular.tint(viewModel.todayStatus == .freezed ? .gray.opacity(0.3) : .cyan), in: Capsule())
            }
            .disabled(viewModel.isFreezeDisabled)

            Text("\(viewModel.freezedCount) out of \(viewModel.maxFreezes) Freezes used")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Helpers

    private func circleIcon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.title3)
            .foregroundStyle(.primary)
            .frame(width: 44, height: 44)
            .glassEffect(.regular, in: Circle())
    }
}

#Preview {
    NavigationStack {
        ActivityView(appViewModel: AppViewModel())
    }
}
