import Combine
import SwiftData
import SwiftUI

@MainActor class HNViewModel: ObservableObject {
    
    @Published var hitsData: [Story] = []
    private let API_URL = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadData()
    }
    
    func loadData() {
        if hitsData.isEmpty {
            Task {
                await fetchNews()
            }
        }
    }
    
    private func fetchNews() async {
        guard let downloadedPosts: HitsModel = await ApiServices().downloadData(fromURL: API_URL) else { return }
        hitsData = downloadedPosts.hits.sorted(by: {
            let date1 = $0.date?.toDateFormat() ?? Date()
            let date2 = $1.date?.toDateFormat() ?? Date()
            return date1.compare(date2) == .orderedDescending
        })
        clearData()
        hitsData.forEach {
            addStory(story: $0)
        }
    }
    
    private func addStory(story: Story) {
        modelContext.insert(StoryModel(title: story.title, author: story.author, url: story.url, date: story.date))
    }

    func deleteItems(story: StoryModel) {
        modelContext.delete(story)
    }
    
    func clearData() {
        do {
            try modelContext.delete(model: StoryModel.self)
        } catch {
            print("Failed to clear all Stories data.")
        }
    }
}
