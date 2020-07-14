import Foundation

private let testExtensionsBackgroundQueue = DispatchQueue(
    label: "testextensions.background.queue",
    qos: .background,
    attributes: .concurrent
)

private let testExtensionsMainQueue = DispatchQueue(
    label: "testextensions.main.queue",
    qos: .userInteractive,
    attributes: .concurrent
)

public extension DispatchQueue {
    class var testExtensionsBackground: DispatchQueue {
        return testExtensionsBackgroundQueue
    }
    class var testExtensionsMain: DispatchQueue {
        return testExtensionsMainQueue
    }
}
