import SwiftUI

struct CustomCellView: View {
    let title: String?
    let subtitle: String?
    let date: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title ?? "")
                .lineLimit(1)
            HStack() {
                Text(subtitle ?? "")
                    .font(.footnote)
                Text("-")
                Text(date?.timeAgoDisplay() ?? "")
                    .font(.footnote)
            }
        }
        .padding()
    }
}
