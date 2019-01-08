import Foundation
import XCTest

public extension XCTestCase {
    // see https://stackoverflow.com/questions/31182637/delay-wait-in-a-test-case-of-xcode-ui-testing
    func wait(for duration: TimeInterval = 0.5, completion: (() -> Void)?) {
        let waitExpectation = expectation(description: "expectation should be automatically fulfilled")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?()
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 1.0) // +1.0 for CI
    }

    func wait(for duration: TimeInterval = 0.5, completionWithHandler: @escaping ((@escaping () -> Void) -> Void)) {
        let waitExpectation = expectation(description: "completion handler should be called to fulfil expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completionWithHandler {
                waitExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: duration + 1.0) // +1.0 for CI
    }
}
