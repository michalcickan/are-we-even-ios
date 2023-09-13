import SwiftUI

enum AccessoryKind {
    case navigation
}

struct AccessoryView: View {
    let kind: AccessoryKind
    
    var body: some View {
        switch kind {
        case .navigation:
            Image(systemName: "chevron.right")
        }
    }
}

struct AccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryView(kind: .navigation)
    }
}
