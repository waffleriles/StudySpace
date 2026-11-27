import SwiftUI
import SwiftData

@main
struct StudySpaceApp: App {
    let modelContainer: ModelContainer = {
        let schema = Schema([Category.self, TaskItem.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [config])
    }()

    init() {
        NotificationManager.shared.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(modelContainer)
    }
}
