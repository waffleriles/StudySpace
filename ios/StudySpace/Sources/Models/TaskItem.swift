import Foundation
import SwiftData

@Model
final class TaskItem {
    var name: String
    var date: Date
    var category: Category?

    init(name: String, date: Date, category: Category?) {
        self.name = name
        self.date = date
        self.category = category
    }
}
