import Foundation

struct ListSection<T>: Identifiable {
    let id = UUID()
    
    let title: String
    let items: [T]
}
