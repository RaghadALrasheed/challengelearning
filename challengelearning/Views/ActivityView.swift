//
//  ActivityView.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 04/06/1448 AH.
//

import SwiftUI

struct ActivityView: View {
    @State private var viewModel = ActivityViewModel()
    private var weekDays: [Date]{
        let calendar = Calendar.current
        guard let start = calendar.dateInterval(of: .weekOfYear, for: Date())?.start else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }
   
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            
            HStack {
                Text("Activity")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Image(systemName: "calendar")
                    .foregroundStyle(.primary)
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.2), in: Circle())
                Image(systemName: "pencil.and.outline")
                    .foregroundStyle(.primary)
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.2), in: Circle())
            }
            Text(Date().formatted(.dateTime.weekday(.wide).day().month(.wide)))
                .foregroundStyle(.secondary)
            HStack {
                ForEach(weekDays, id: \.self) { date in
                    VStack(spacing: 8) {
                        Text(date.formatted(.dateTime.weekday(.narrow)))
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.primary)
                        Text(date.formatted(.dateTime.day()))
                            .frame(width: 36, height: 36)
                            .background(
                                viewModel.status(for: date) == .learned ? Color.orange.opacity(0.3) :
                                viewModel.status(for: date) == .freezed ? Color.cyan.opacity(0.3) :
                                Calendar.current.isDateInToday(date) ? Color.orange : Color.clear,
                                in: Circle()
                            )                   }
                    .frame(maxWidth: .infinity)
                }
            }
            HStack {
                VStack {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(.orange)
                    Text("\(viewModel.learnedCount) \(viewModel.learnedCount == 1 ? "day" : "days")")
                        .bold()
                    Text("Learned")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
                
                VStack {
                    Image(systemName: "snowflake")
                        .foregroundStyle(.cyan)
                    Text("\(viewModel.freezedCount) \(viewModel.freezedCount == 1 ? "day" : "days")")
                        .bold()
                    Text("Freezed")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
            }
            Spacer()
            
            Button {
                viewModel.toggleLearned()
            }label: {
                Text(viewModel.todayStatus == .learned ? "Logged as Learned" : "Log as Learned")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 240, height: 240)
                    .background(viewModel.todayStatus == .learned ? Color.gray.opacity(0.2) : Color.orange, in: Circle())
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            Button {
                viewModel.toggleFreeze()
            }label: {
                Text(viewModel.todayStatus == .freezed ? "Freezed for a day" : "Freeze for a day")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .glassEffect(.regular.tint(viewModel.todayStatus == .freezed ? .gray.opacity(0.3) : .cyan), in: Capsule())
                }
            .disabled(viewModel.todayStatus != .freezed && viewModel.freezedCount >= viewModel.maxFreezes)
            Text("\(viewModel.freezedCount) out of \(viewModel.maxFreezes) Freezes used")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
    }
#Preview {
    ActivityView()
}

