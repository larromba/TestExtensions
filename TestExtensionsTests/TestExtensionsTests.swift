@testable import TestExtensions
import XCTest

final class TestExtensionsTests: XCTestCase {
    func testWaitAutomaticCompletion() {
        let expectation = self.expectation(description: "wait callback invoked")
        let date = Date()
        wait(for: 1.0) {
            XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(date), 1.0)
            expectation.fulfill()
        }
    }

    func testWaitManualCompletion() {
        let expectation = self.expectation(description: "wait callback invoked")
        let date = Date()
        wait(for: 1.0) { completion in
            XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(date), 1.0)
            expectation.fulfill()
            completion()
        }
    }
}
