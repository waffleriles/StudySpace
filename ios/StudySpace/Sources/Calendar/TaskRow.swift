import SwiftUI
import SwiftData

struct TaskRow: View {
    @Environment(\.modelContext) private var context
    @Bindable var task: TaskItem

    var body: some View {
        HStack {
            Button {
                // Matches the Android app: completing a task deletes it
                // rather than just marking it done.
                context.delete(task)
            } label: {
                Image(systemName: "circle")
                    .foregroundStyle(task.category?.colorHex.map { Color(hex: $0) } ?? .secondary)
            }
            .buttonStyle(.plain)

            TextField("Task", text: $task.name)
        }
    }
}
