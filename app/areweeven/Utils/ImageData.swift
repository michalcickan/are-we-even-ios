import Foundation
import SwiftUI

enum ImageData {
    case imageAsset(_ asset: ImageAsset)
    case systemName(_ systemName: String)
}

extension ImageData {
    var image: Image {
        switch self {
        case let .imageAsset(asset):
            return asset.swiftUIImage
        case let .systemName(name):
            return Image(systemName: name)
        }
    }
}
