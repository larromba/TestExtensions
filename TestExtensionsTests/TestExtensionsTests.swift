@testable import TestExtensions
import XCTest

final class TestExtensionsTests: XCTestCase {
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

    func testWaitSync() {
        // sut
        waitSync(for: 1.0)

        // tests
        XCTAssertGreaterThanOrEqual(timeElapsed, 1.0)
        XCTAssertLessThanOrEqual(timeElapsed, 5.0)
    }

    func testWaitSyncMultiple() {
        // 1.
        // sut
        waitSync(for: 1.0)

        // tests
        XCTAssertGreaterThanOrEqual(timeElapsed, 1.0)
        XCTAssertLessThanOrEqual(timeElapsed, 5.0)

        // 2.
        // sut
        waitSync(for: 1.0)

        // tests
        XCTAssertGreaterThanOrEqual(timeElapsed, 2.0)
        XCTAssertLessThanOrEqual(timeElapsed, 6.0)
    }

    func testWaitAsync() {
        // sut
        waitAsync(for: 1.0) { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion()
            }
        }

        // tests
        XCTAssertGreaterThanOrEqual(timeElapsed, 1.0)
        XCTAssertLessThanOrEqual(timeElapsed, 5.0)
    }

    func testMultipleWaitAsync() {
        // 1.
        // sut
        waitAsync(for: 1.0) { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion()
            }
        }
        
        // tests
        XCTAssertGreaterThanOrEqual(timeElapsed, 1.0)
        XCTAssertLessThanOrEqual(timeElapsed, 5.0)

        // 2.
        // sut
        waitAsync(for: 1.0) { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion()
            }
        }

        // tests
        XCTAssertGreaterThanOrEqual(timeElapsed, 2.0)
        XCTAssertLessThanOrEqual(timeElapsed, 6.0)
    }
}
