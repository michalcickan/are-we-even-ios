import Foundation
import Alamofire

extension HTTPHeader {
    static func deviceId(value: String) -> HTTPHeader {
        HTTPHeader(name: "X-Device-ID", value: value)
    }
}
