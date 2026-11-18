import SwiftUI

struct LearningGoalView: View {
    @State private var viewModel: LearningGoalViewModel

    @Environment(\.dismiss) private var dismiss

    init(appViewModel: AppViewModel) {
        _viewModel = State(initialValue: LearningGoalViewModel(appViewModel: appViewModel))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("I want to learn")
            TextField("Swift", text: $viewModel.topic)
                .font(.title3)
            Divider()
            Text("I want to learn it in a")
            DurationPicker(selection: $viewModel.duration)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("Learning Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if viewModel.needsConfirmation {
                        viewModel.showAlert = true
                    } else {
                        viewModel.saveGoal()
                        dismiss()
                    }
                } label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
                .tint(.orange)
            }
        }
        .alert("Update goal", isPresented: $viewModel.showAlert) {
            Button("Dismiss", role: .cancel) { }
            Button("Update") {
                viewModel.saveGoal()
                dismiss()
            }
            .keyboardShortcut(.defaultAction)
        } message: {
            Text("If you update now, your streak will start over.")
        }
    }
}

#Preview {
    NavigationStack {
        LearningGoalView(appViewModel: AppViewModel())
    }
}
