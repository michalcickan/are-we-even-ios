import SwiftUI

struct TextDivider: View {

    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        HStack {
            line
            Text(text).foregroundColor(Color.black)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(.black) }
    }
}
