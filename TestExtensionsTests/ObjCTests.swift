@testable import TestExtensions
import XCTest

final class ObjCTests: XCTestCase {
    func test_msgSend_whenCalledOnButton_expectInvokesAction() {
        // mocks
        final class MockClass {
            var value: NSNumber?

            @objc
            func test(_ value: NSNumber) {
                self.value = value
            }
        }
        let target = MockClass()
        let value = 100
        let object = NSNumber(value: value)

        // sut
        msgSend(target: target, action: #selector(MockClass.test(_:)), object: object)

        // test
        XCTAssertEqual(target.value?.intValue, value)
    }
}
