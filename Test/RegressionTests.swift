import BoardingPassKit
import XCTest

/// These tests contain boarding passes seen in the wild that failed parsing.
/// All personal details are obfuscated and some fields not necessary to reproduce the bug may be removed.
class RegressionTests: XCTestCase {
	/// 0.2.0 introduced a new way of parsing document numbers, which broke when the document airline field was unable to be parsed as a
	/// number. The following 10 characters (serial number) would then not be ignored and instead be used to parse other fields.
	func testBlankDocumentRegression() throws {
		let data = "M1LASTNAME/FIRSTNAME  EABCDEF CCCFFFAB 1234 314Y001A0025 12C>6180 M    BAB              0E             3"
			.data(using: .ascii)!
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 1)
		let leg = boardingPass.legs[0]
		XCTAssertNil(leg.documentNumber)
		XCTAssertEqual(leg.selectee, "3")
	}
}
