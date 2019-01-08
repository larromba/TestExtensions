@testable import TestExtensions
import XCTest

final class TestExtensionsTests: XCTestCase {
    func testWait() {
        let expectation = self.expectation(description: "wait callback invoked")
        let date = Date()
        wait(for: 1.0) {
            XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(date), 1.0)
            expectation.fulfill()
        }
    }
}
