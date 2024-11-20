import Foundation

extension String {
    
    func toDateFormat() -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self) ?? Date()
    }
    
    func timeAgoDisplay() -> String {
        let date = self.toDateFormat()
        return date.timeAgoDisplay()
    }
}
