import Foundation

struct HitsModel: Codable {
    let hits: [Story]
    
    enum CodingKeys: String, CodingKey {
        case hits = "hits"
    }
}

struct Story: Identifiable, Codable {
    let id: String
    let comment: String?
    let title: String?
    let author: String?
    let date: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case comment = "comment_text"
        case title = "story_title"
        case author
        case url = "story_url"
        case date = "created_at"
    }
}
