import SwiftUI
import SwiftData

@main
struct HNMobileTestApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            StoryModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: HNViewModel(modelContext: sharedModelContainer.mainContext))
        }
        .modelContainer(sharedModelContainer)
    }
}
