import Foundation
import XCTest

public extension XCTestCase {
    // see https://stackoverflow.com/questions/31182637/delay-wait-in-a-test-case-of-xcode-ui-testing
    func waitSync(for duration: TimeInterval = 0.5) {
        let expectation = self.expectation(description: "wait synchronously")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: duration + 1.0) // +1.0 for CI
    }

    func waitAsync(for duration: TimeInterval = 0.5, completion: @escaping (@escaping () -> Void) -> Void) {
        let expectation = self.expectation(description: "wait asynchronously for callback")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion {
                DispatchQueue.main.async { expectation.fulfill() }
            }
        }
        waitForExpectations(timeout: duration + 1.0) // +1.0 for CI
    }
}
