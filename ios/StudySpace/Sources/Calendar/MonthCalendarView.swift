import SwiftUI

struct MonthCalendarView: View {
    @Binding var displayedMonth: Date
    @Binding var selectedDate: Date?
    let dotColors: (Date) -> [Color]

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 8) {
            weekdayLabels

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Array(daysInMonth.enumerated()), id: \.offset) { _, day in
                    if let day {
                        DayCell(
                            date: day,
                            isSelected: calendar.isDate(day, inSameDayAs: selectedDate ?? .distantPast) && selectedDate != nil,
                            isToday: calendar.isDateInToday(day),
                            dotColors: dotColors(day)
                        )
                        .onTapGesture {
                            if let selectedDate, calendar.isDate(day, inSameDayAs: selectedDate) {
                                self.selectedDate = nil
                            } else {
                                self.selectedDate = day
                            }
                        }
                    } else {
                        Color.clear
                    }
                }
            }
        }
    }

    private var weekdayLabels: some View {
        HStack {
            ForEach(calendar.shortWeekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // Days for the currently displayed month, padded with nils so the
    // first day lines up under the correct weekday column.
    private var daysInMonth: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth) else { return [] }
        let firstWeekday = calendar.component(.weekday, from: monthInterval.start)
        let leadingBlanks = (firstWeekday - calendar.firstWeekday + 7) % 7

        var days: [Date?] = Array(repeating: nil, count: leadingBlanks)
        var date = monthInterval.start
        while date < monthInterval.end {
            days.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        while days.count % 7 != 0 { days.append(nil) }
        return days
    }
}
