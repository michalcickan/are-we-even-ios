import SwiftUI

struct ListItemCellViewModel: Identifiable {
    typealias ID = String
    
    let id: ID
    let title: String
    let subtitle: String?
    let icon: ImageData?
    let accessoryKind: AccessoryKind?
    
    let onSelected: () -> Void
    
    init(id: ID,
         title: String,
         subtitle: String? = nil,
         icon: ImageData? = nil,
         accessoryKind: AccessoryKind? = nil,
         onSelected: @escaping () -> Void) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.accessoryKind = accessoryKind
        self.onSelected = onSelected
    }
}

struct ListItemCellView: View {
    let viewModel: ListItemCellViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            if let image = viewModel.icon?.image {
                image
                    .resizable()
                    .frame(width: 24, height: 24)
                    .aspectRatio(contentMode: .fill)
                    .padding(.trailing, 10)
            }
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.headline)
                if let subtitle = viewModel.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            if let kind = viewModel.accessoryKind {
                Spacer()
                AccessoryView(kind: kind)
            }
        }
        .onTapGesture(perform: viewModel.onSelected)
    }
}

struct ListItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListItemCellView(
                viewModel: .init(
                    id: "a",
                    title: "afasdf adfjk a;lkfj da;lfjk da;f ad fd;aj kfd;ajkdl f;jkl; fdjklajdf ;jk",
                    subtitle: "b",
                    icon: .imageAsset(Asset.icHome),
                    accessoryKind: .navigation
                ) { print("ok") }
            )
        }
    }
}
