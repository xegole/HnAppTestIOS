import Foundation
import SwiftData

@Model
final class StoryModel {
    var title: String?
    var author: String?
    var url: String?
    var date: String?
    
    init(title: String?, author: String?, url: String?, date: String?) {
        self.title = title
        self.author = author
        self.url = url
        self.date = date
    }
}
