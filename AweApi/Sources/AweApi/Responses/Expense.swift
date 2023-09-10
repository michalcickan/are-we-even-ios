import Foundation

public struct Expense: Decodable {
    public let id: Int
    public let description: String
    public let totalAmount: Double
    @DateTransformer
    public var createdAt: Date?
    public let participants: [ExpenseUser]?
}
