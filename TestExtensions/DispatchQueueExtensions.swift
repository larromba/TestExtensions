import Foundation

private let testExtensionsQueue = DispatchQueue(label: "testextensions.queue", attributes: .concurrent)

public extension DispatchQueue {
    class var testExtensions: DispatchQueue {
        return testExtensionsQueue
    }
}
