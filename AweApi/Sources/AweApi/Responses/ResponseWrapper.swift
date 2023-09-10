import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    let data: T?
    let error: ApiError?
}
