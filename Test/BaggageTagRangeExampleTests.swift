import BoardingPassKit
import XCTest

class BaggageTagRangeExampleTests: XCTestCase {
	func testExample1() throws {
		let data = "0016111111001".data(using: .ascii)!
		let tagRange = try BPKBaggageTagRange(data: data)
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 16)
		XCTAssertEqual(tagRange.numberRange, 111111...111112)
	}

	func testExample2() throws {
		let data = "0016111111000".data(using: .ascii)!
		let tagRange = try BPKBaggageTagRange(data: data)
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 16)
		XCTAssertEqual(tagRange.numberRange, 111111...111111)
	}
}
