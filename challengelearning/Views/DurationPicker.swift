import SwiftUI

struct DurationPicker: View {
    @Binding var selection: LearningDuration

    var body: some View {
        HStack {
            ForEach(LearningDuration.allCases, id: \.self) { item in
                Button(item.title) {
                    selection = item
                }
                .buttonStyle(.glassProminent)
                .tint(selection == item ? .orange : .gray.opacity(0.3))
                .font(.title3)                     // ⬅️ نفس اللي عندك
            }
        }
    }
}

#Preview {
    DurationPicker(selection: .constant(.week))
}
