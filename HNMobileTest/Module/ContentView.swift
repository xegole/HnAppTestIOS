import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject var viewModel: HNViewModel
    @Query(sort: \StoryModel.date, order: .reverse) var stories: [StoryModel]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(stories) { story in
                    NavigationLink(destination: CustomWebView(url: URL(string: story.url ?? ""))
                        .navigationTitle(story.title ?? "HN APP")
                        .navigationBarTitleDisplayMode(.inline)) {
                            CustomCellView(title: story.title, subtitle: story.author, date: story.date)
                        }
                }
                .onDelete(perform: removeRows)
            }
            .refreshable {
                viewModel.loadData()
            }
        } detail: {
            Text("Select an item")
        }.navigationTitle("Stories")
    }
    
    private func removeRows(at offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteItems(story: stories[index])
        }
    }
}
