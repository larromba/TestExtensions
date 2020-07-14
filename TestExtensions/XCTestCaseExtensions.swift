import Foundation
import XCTest

public extension XCTestCase {
    // see https://stackoverflow.com/questions/31182637/delay-wait-in-a-test-case-of-xcode-ui-testing
    func waitSync(for duration: TimeInterval = 0.5, queue: DispatchQueue = .testExtensionsBackground) {
        let expectation = self.expectation(description: "wait synchronously")
        queue.asyncAfter(deadline: .now() + duration) {
            DispatchQueue.testExtensionsMain.async { expectation.fulfill() }
        }
        waitForExpectations(timeout: duration + 1.5) // +1.5 for CI
    }

    func waitAsync(for duration: TimeInterval = 0.5, delay: TimeInterval = 0.0,
                   queue: DispatchQueue = .testExtensionsBackground,
                   completion: @escaping (@escaping () -> Void) -> Void) {
        let expectation = self.expectation(description: "wait asynchronously for callback")
        queue.asyncAfter(deadline: .now() + delay) {
            completion {
                DispatchQueue.testExtensionsMain.async { expectation.fulfill() }
            }
        }
        waitForExpectations(timeout: delay + duration)
    }
}
