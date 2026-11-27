import SwiftUI

struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let dotColors: [Color]

    var body: some View {
        VStack(spacing: 4) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(isToday ? .body.bold() : .body)
                .foregroundStyle(isSelected ? .white : (isToday ? .purple : .primary))
                .frame(width: 32, height: 32)
                .background(isSelected ? Color.purple : Color.clear)
                .clipShape(Circle())

            HStack(spacing: 2) {
                ForEach(Array(dotColors.prefix(4).enumerated()), id: \.offset) { _, color in
                    Circle().fill(color).frame(width: 5, height: 5)
                }
                if dotColors.count > 4 {
                    Text("+").font(.system(size: 8)).foregroundStyle(.secondary)
                }
            }
            .frame(height: 6)
        }
    }
}
