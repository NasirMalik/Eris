import XCTest
@testable import Ceres

final class CeresServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CeresService().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
