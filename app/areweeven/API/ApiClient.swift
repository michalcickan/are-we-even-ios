import Foundation
import AweApi
import UIKit

let apiClient: Client = {
   return Client(
    baseUrl: Environment.value(for: .apiBaseUrl),
    tokensProvider: AuthManager.shared,
    tokensStorage: AuthManager.shared,
    deviceId: (UIDevice.current.identifierForVendor ?? UUID()).uuidString
   )
}()
