import SwiftUI
import SwiftData

struct AddCategorySheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var selectedColorHex = CategoryPalette.colors[0]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Category name", text: $name)

                Section("Color") {
                    HStack(spacing: 12) {
                        ForEach(CategoryPalette.colors, id: \.self) { hex in
                            Circle()
                                .fill(Color(hex: hex))
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Circle().stroke(.black, lineWidth: selectedColorHex == hex ? 3 : 0)
                                )
                                .onTapGesture { selectedColorHex = hex }
                        }
                    }
                }
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = name.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        context.insert(Category(name: trimmed, colorHex: selectedColorHex))
                        dismiss()
                    }
                }
            }
        }
    }
}
