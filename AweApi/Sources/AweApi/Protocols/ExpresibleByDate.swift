import Foundation

public protocol ExpressibleByDate {
    init(_ date: Date)
    var date: OptionalValue<Date> { get }
}

extension Date: ExpressibleByDate {
    public init(_ date: Date) {
        self = date
    }
    
    public var date: OptionalValue<Date> { .value(self) }
}

extension Optional: ExpressibleByDate where Wrapped == Date {
    public init(_ date: Date) {
        self = date
    }
    
    public var date: OptionalValue<Date> { self != nil ? .value(self!) : .none }
}
