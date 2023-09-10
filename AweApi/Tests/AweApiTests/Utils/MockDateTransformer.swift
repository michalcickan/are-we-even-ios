import Foundation

@testable import AweApi

struct MockDateTransformer: Codable {
    @DateTransformer
    var date: Date?
    
    init(date: Date? = nil) {
        _date = .init(date: date)
    }
}
