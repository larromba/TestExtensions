@testable import TestExtensions
import XCTest

final class XCTestCaseExtensionsTests: XCTestCase {
    private var startDate: Date!
    private var timeElapsed: TimeInterval {
        return Date().timeIntervalSince(startDate)
    }

    override func setUp() {
        super.setUp()
        startDate = Date()
    }

    override func tearDown() {
        startDate = nil
        super.tearDown()
    }

    // MARK: - waitSync

    func test_waitSync_whenInvokedWithDuration_expectCorrectDuration() {
        // mocks
        let duration = 1.0

        // sut
        waitSync(for: duration)

        // tests
        XCTAssertEqual(timeElapsed, duration, accuracy: 0.2)
    }

    func test_waitSync_whenInvokedWithDurationMultipleTimes_expectCorrectDuration() {
        // 1.
        // mocks
        let duration = 1.0

        // sut
        waitSync(for: duration)

        // tests
        XCTAssertEqual(timeElapsed, duration, accuracy: 0.2)

        // 2.
        // mocks
        startDate = Date()

        // sut
        waitSync(for: duration)

        // tests
        XCTAssertEqual(timeElapsed, duration, accuracy: 0.2)
    }

    // MARK: - waitAsync

    func test_waitAsync_whenInvokedWithCompletion_expectCorrectDuration() {
        // mocks
        let asyncDuration = 0.2

        // sut
        waitAsync { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + asyncDuration) {
                completion()
            }
        }

        // tests
        XCTAssertEqual(timeElapsed, asyncDuration, accuracy: 0.2)
    }

    func test_waitAsync_whenInvokedWithCompletionMultipleTimes_expectCorrectDuration() {
        // 1.
        // mocks
        let asyncDuration = 0.2

        // sut
        waitAsync { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + asyncDuration) {
                completion()
            }
        }
        
        // tests
        XCTAssertEqual(timeElapsed, asyncDuration, accuracy: 0.2)

        // 2.
        // mocks
        startDate = Date()

        // sut
        waitAsync { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + asyncDuration) {
                completion()
            }
        }

        // tests
        XCTAssertEqual(timeElapsed, asyncDuration, accuracy: 0.2)
    }

    func test_waitAsync_whenInvokedWithDelay_expectCorrectDuration() {
        // mocks
        let delay = 0.5
        let asyncDuration = 0.2

        // sut
        waitAsync(delay: delay) { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + asyncDuration) {
                completion()
            }
        }

        // tests
        XCTAssertEqual(timeElapsed, (delay + asyncDuration), accuracy: 0.2)
    }

    func test_waitAsync_whenInvokedOnBackgroundQueue_expectThreadNotOnMain() {
        // 1.
        // sut
        waitAsync(queue: .global()) { completion in
            // tests
            XCTAssertFalse(Thread.isMainThread)
            completion()
        }
    }
}
