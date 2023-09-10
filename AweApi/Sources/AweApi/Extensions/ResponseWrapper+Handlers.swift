import Foundation

extension ResponseWrapper where T: Decodable {
    func extractModel() throws -> T {
        guard let data = data else {
            throw error!
        }
        return data
    }
}
