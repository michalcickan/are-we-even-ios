import Foundation

public struct ExpenseUser: Decodable {
    public let id: Int
    public let name: String?
    public let paidAmount: Double
    public let dueAmount: Double
}
