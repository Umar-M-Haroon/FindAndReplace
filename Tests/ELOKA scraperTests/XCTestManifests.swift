import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ELOKA_scraperTests.allTests),
    ]
}
#endif
