import SwiftUI
import SwiftData

struct CategorySectionView: View {
    @Environment(\.modelContext) private var context
    let category: Category
    let date: Date

    @State private var isAddingTask = false
    @State private var newTaskName = ""
    @FocusState private var isNewTaskFocused: Bool

    private var tasksForDate: [TaskItem] {
        category.tasks.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    var body: some View {
        Section {
            ForEach(tasksForDate) { task in
                TaskRow(task: task)
            }
            .onDelete { offsets in
                for index in offsets { context.delete(tasksForDate[index]) }
            }

            if isAddingTask {
                TextField("New task", text: $newTaskName)
                    .focused($isNewTaskFocused)
                    .onSubmit { commitNewTask() }
            } else {
                Button("+ Add Task") {
                    isAddingTask = true
                    isNewTaskFocused = true
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        } header: {
            Text(category.name)
                .font(.headline)
                .foregroundStyle(Color(hex: category.colorHex))
                .contextMenu {
                    Button("Delete Category", role: .destructive) {
                        context.delete(category)
                    }
                }
        }
    }

    private func commitNewTask() {
        let trimmed = newTaskName.trimmingCharacters(in: .whitespaces)
        if !trimmed.isEmpty {
            context.insert(TaskItem(name: trimmed, date: date, category: category))
        }
        newTaskName = ""
        isAddingTask = false
    }
}
