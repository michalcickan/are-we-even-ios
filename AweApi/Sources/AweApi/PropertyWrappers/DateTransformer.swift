import Foundation

@propertyWrapper
public struct DateTransformer<DateValue: ExpressibleByDate & Codable>: Codable {
    public var wrappedValue: DateValue
    
    init(date: DateValue) {
        self.wrappedValue = date
    }
    
    public init(from decoder: Decoder) throws {
        let source = try TimeInterval(from: decoder)
        wrappedValue = DateValue(Date(timeIntervalSince1970: source / 1000))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch (wrappedValue.date) {
        case let .value(date):
            try container.encode(date.timeIntervalSince1970 * 1000)
        case .none:
            try container.encodeNil()
        }
    }
}
