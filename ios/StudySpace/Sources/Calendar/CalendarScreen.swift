import SwiftUI
import SwiftData

struct CalendarScreen: View {
    @Query(sort: \Category.createdAt) private var categories: [Category]
    @Query private var allTasks: [TaskItem]

    @State private var displayedMonth = Date.now
    @State private var selectedDate: Date? = .now
    @State private var showingAddCategory = false

    private let calendar = Calendar.current

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                monthHeader

                MonthCalendarView(
                    displayedMonth: $displayedMonth,
                    selectedDate: $selectedDate,
                    dotColors: dotColors(for:)
                )
                .padding(.horizontal)

                if let selectedDate {
                    Text(selectedDate.formatted(.dateTime.weekday(.wide).month().day()))
                        .font(.headline)
                        .padding(.vertical, 8)
                }

                List {
                    ForEach(categories) { category in
                        CategorySectionView(category: category, date: selectedDate ?? .now)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("StudySpace")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddCategory = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddCategory) {
                AddCategorySheet()
            }
        }
    }

    private var monthHeader: some View {
        HStack {
            Button { changeMonth(by: -1) } label: { Image(systemName: "chevron.left") }
            Spacer()
            Text(displayedMonth.formatted(.dateTime.month(.wide).year()))
                .font(.title3.bold())
            Spacer()
            Button { changeMonth(by: 1) } label: { Image(systemName: "chevron.right") }
        }
        .padding()
    }

    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = newMonth
        }
    }

    private func dotColors(for date: Date) -> [Color] {
        allTasks
            .filter { calendar.isDate($0.date, inSameDayAs: date) }
            .compactMap { $0.category?.colorHex }
            .map { Color(hex: $0) }
    }
}
