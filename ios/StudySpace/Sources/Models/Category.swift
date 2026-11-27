import Foundation
import SwiftData

@Model
final class Category {
    var name: String
    var colorHex: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \TaskItem.category)
    var tasks: [TaskItem] = []

    init(name: String, colorHex: String) {
        self.name = name
        self.colorHex = colorHex
        self.createdAt = .now
    }
}
