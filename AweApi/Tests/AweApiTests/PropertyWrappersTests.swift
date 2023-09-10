import Foundation
import Quick
import Nimble

@testable import AweApi

class PropertyWrappersTests: QuickSpec {
    override class func spec() {
        describe("PropertyWrappersTests") {
            context("DateTransformer") {
                it("should decode unix date correctly") {
                    let jsonTimestamp: TimeInterval = 1693394680540
                    let json = """
                        {
                            "date": \(jsonTimestamp)
                        }
                        """
                    let model = try JSONDecoder().decode(
                        MockDateTransformer.self,
                        from: json.data(using: .utf8)!
                    )
                    
                    expect(model.date?.timeIntervalSince1970)
                        .to(equal(jsonTimestamp/1000))
                }
                
                it("should encode as unix date") {
                    let expectedTimestamp: TimeInterval = 1693394680
                    let model = MockDateTransformer(date: Date(timeIntervalSince1970: expectedTimestamp))
                    let encoded = try? JSONEncoder().encode(model)
                    
                    let json = try? JSONSerialization.jsonObject(with: encoded!, options: []) as? [String: Any]
                    
                    expect(json?["date"] as? TimeInterval)
                        .to(equal(expectedTimestamp*1000))
                }
            }
        }
    }
}
