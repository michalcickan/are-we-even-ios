import Foundation
import AweApi
import UIKit

let apiClient: Client = {
   return Client(
    baseUrl: Config.baseAPIUrl,
    tokensProvider: AuthManager.shared,
    deviceId: (UIDevice.current.identifierForVendor ?? UUID()).uuidString
   )
}()
