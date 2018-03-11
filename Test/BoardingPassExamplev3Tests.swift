import BoardingPassKit
import XCTest

class BoardingPassExamplev3Tests: XCTestCase {
	private let securityData = "GIWVC5EH7JNT684FVNJ91W2QA4DVN5J8K4F0L0GEQ3DF5TGBN8709HKT5D3DW3GBHFCVHMY7J5T6HFR41W2QA4DVN5J8K4F0L0GE"
		.data(using: .ascii)!

	func testExample1() throws {
		let data = ("M1DESMARAIS/LUC       EABC123 YULFRAAC 0834 226F001A0025 100^164").data(using: .ascii)! + securityData
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 1)
		XCTAssertEqual(boardingPass.firstName, "LUC")
		XCTAssertEqual(boardingPass.lastName, "DESMARAIS")
		XCTAssertEqual(boardingPass.securityType, "1")
		XCTAssertEqual(boardingPass.securityData, securityData)

		let leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "ABC123")
		XCTAssertEqual(leg.fromIATA, "YUL")
		XCTAssertEqual(leg.toIATA, "FRA")
		XCTAssertEqual(leg.operatingAirlineIATA, "AC")
		XCTAssertEqual(leg.flightNumber, "0834")
		XCTAssertEqual(leg.dayOfYear, 226)
		XCTAssertEqual(leg.cabinCode, "F")
		XCTAssertEqual(leg.seatNumber, "001A")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")
	}

	func testExample2() throws {
		let data = "M1DESMARAIS/LUC       EABC123 YULFRAAC 0834 226F001A0025 14C>3181WW6225BAC 0085123456003290141234567890 1AC AC 1234567890123    2PCLX58Z^164".data(using: .ascii)! + securityData
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 1)
		XCTAssertEqual(boardingPass.firstName, "LUC")
		XCTAssertEqual(boardingPass.lastName, "DESMARAIS")
		XCTAssertEqual(boardingPass.securityType, "1")
		XCTAssertEqual(boardingPass.securityData, securityData)

		XCTAssertEqual(boardingPass.passengerDescription, "1")
		XCTAssertEqual(boardingPass.checkinSource, "W")
		XCTAssertEqual(boardingPass.boardingPassSource, "W")
		XCTAssertEqual(boardingPass.boardingPassIssueYear, 6)
		XCTAssertEqual(boardingPass.boardingPassIssueDay, 225)
		XCTAssertEqual(boardingPass.documentType, "B")
		XCTAssertEqual(boardingPass.boardingPassIssuer, "AC")

		XCTAssertEqual(boardingPass.baggageTagRanges.count, 1)
		let tagRange = boardingPass.baggageTagRanges[0]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 85)
		XCTAssertEqual(tagRange.numberRange, 123456...123459)

		let leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "ABC123")
		XCTAssertEqual(leg.fromIATA, "YUL")
		XCTAssertEqual(leg.toIATA, "FRA")
		XCTAssertEqual(leg.operatingAirlineIATA, "AC")
		XCTAssertEqual(leg.flightNumber, "0834")
		XCTAssertEqual(leg.dayOfYear, 226)
		XCTAssertEqual(leg.cabinCode, "F")
		XCTAssertEqual(leg.seatNumber, "001A")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 14)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertEqual(leg.internationalDocumentVerification, "1")
		XCTAssertEqual(leg.marketingAirlineIATA, "AC")
		XCTAssertEqual(leg.frequentFlyerAirline, "AC")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "2PC")
		XCTAssertEqual(leg.airlineData, "LX58Z".data(using: .ascii)!)
	}

	func testExample3() throws {
		let data = "M1GRANDMAIRE/MELANIE  EABC123 GVACDGAF 0123 228C002F0025 113>3000D0571234567890^164"
			.data(using: .ascii)! + securityData
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 1)
		XCTAssertEqual(boardingPass.firstName, "MELANIE")
		XCTAssertEqual(boardingPass.lastName, "GRANDMAIRE")
		XCTAssertEqual(boardingPass.securityType, "1")
		XCTAssertEqual(boardingPass.securityData, securityData)

		let leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "ABC123")
		XCTAssertEqual(leg.fromIATA, "GVA")
		XCTAssertEqual(leg.toIATA, "CDG")
		XCTAssertEqual(leg.operatingAirlineIATA, "AF")
		XCTAssertEqual(leg.flightNumber, "0123")
		XCTAssertEqual(leg.dayOfYear, 228)
		XCTAssertEqual(leg.cabinCode, "C")
		XCTAssertEqual(leg.seatNumber, "002F")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 57)
		XCTAssertEqual(leg.documentNumber, "1234567890")
	}

	func testExample4() throws {
		let data = "M2DESMARAIS/LUC       EABC123 YULFRAAC 0834 226F001A0025 14C>3181WW6225BAC 0085123456003290141234567890 1AC AC 1234567890123    20KLX58ZDEF456 FRAGVALH 3664 227C012C0002 12D290140987654321 1AC AC 1234567890123    2PCWQ^164"
			.data(using: .ascii)! + securityData
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 2)
		XCTAssertEqual(boardingPass.firstName, "LUC")
		XCTAssertEqual(boardingPass.lastName, "DESMARAIS")
		XCTAssertEqual(boardingPass.securityType, "1")
		XCTAssertEqual(boardingPass.securityData, securityData)

		XCTAssertEqual(boardingPass.passengerDescription, "1")
		XCTAssertEqual(boardingPass.checkinSource, "W")
		XCTAssertEqual(boardingPass.boardingPassSource, "W")
		XCTAssertEqual(boardingPass.boardingPassIssueYear, 6)
		XCTAssertEqual(boardingPass.boardingPassIssueDay, 225)
		XCTAssertEqual(boardingPass.documentType, "B")
		XCTAssertEqual(boardingPass.boardingPassIssuer, "AC")

		XCTAssertEqual(boardingPass.baggageTagRanges.count, 1)
		let tagRange = boardingPass.baggageTagRanges[0]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 85)
		XCTAssertEqual(tagRange.numberRange, 123456...123459)

		var leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "ABC123")
		XCTAssertEqual(leg.fromIATA, "YUL")
		XCTAssertEqual(leg.toIATA, "FRA")
		XCTAssertEqual(leg.operatingAirlineIATA, "AC")
		XCTAssertEqual(leg.flightNumber, "0834")
		XCTAssertEqual(leg.dayOfYear, 226)
		XCTAssertEqual(leg.cabinCode, "F")
		XCTAssertEqual(leg.seatNumber, "001A")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 14)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertEqual(leg.internationalDocumentVerification, "1")
		XCTAssertEqual(leg.marketingAirlineIATA, "AC")
		XCTAssertEqual(leg.frequentFlyerAirline, "AC")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "20K")
		XCTAssertEqual(leg.airlineData, "LX58Z".data(using: .ascii)!)

		leg = boardingPass.legs[1]
		XCTAssertEqual(leg.pnrCode, "DEF456")
		XCTAssertEqual(leg.fromIATA, "FRA")
		XCTAssertEqual(leg.toIATA, "GVA")
		XCTAssertEqual(leg.operatingAirlineIATA, "LH")
		XCTAssertEqual(leg.flightNumber, "3664")
		XCTAssertEqual(leg.dayOfYear, 227)
		XCTAssertEqual(leg.cabinCode, "C")
		XCTAssertEqual(leg.seatNumber, "012C")
		XCTAssertEqual(leg.checkinSequence, "0002")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 14)
		XCTAssertEqual(leg.documentNumber, "0987654321")
		XCTAssertNil(leg.selectee)
		XCTAssertEqual(leg.internationalDocumentVerification, "1")
		XCTAssertEqual(leg.marketingAirlineIATA, "AC")
		XCTAssertEqual(leg.frequentFlyerAirline, "AC")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "2PC")
		XCTAssertEqual(leg.airlineData, "WQ".data(using: .ascii)!)
	}

	func testExample5() throws {
		let data = "M2GRANDMAIRE/MELANIE  EABC123 GVACDGAF 0123 228C002F0025 12F>300290571234567890                         20KDEF456 CDGDTWNW 0049 228F001A0002 12B29012098765432101                       2PC^164"
			.data(using: .ascii)! + securityData
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 2)
		XCTAssertEqual(boardingPass.firstName, "MELANIE")
		XCTAssertEqual(boardingPass.lastName, "GRANDMAIRE")
		XCTAssertEqual(boardingPass.securityType, "1")
		XCTAssertEqual(boardingPass.securityData, securityData)

		var leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "ABC123")
		XCTAssertEqual(leg.fromIATA, "GVA")
		XCTAssertEqual(leg.toIATA, "CDG")
		XCTAssertEqual(leg.operatingAirlineIATA, "AF")
		XCTAssertEqual(leg.flightNumber, "0123")
		XCTAssertEqual(leg.dayOfYear, 228)
		XCTAssertEqual(leg.cabinCode, "C")
		XCTAssertEqual(leg.seatNumber, "002F")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 57)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertNil(leg.internationalDocumentVerification)
		XCTAssertNil(leg.marketingAirlineIATA)
		XCTAssertNil(leg.frequentFlyerAirline)
		XCTAssertNil(leg.frequentFlyerNumber)
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "20K")
		XCTAssertNil(leg.airlineData)

		leg = boardingPass.legs[1]
		XCTAssertEqual(leg.pnrCode, "DEF456")
		XCTAssertEqual(leg.fromIATA, "CDG")
		XCTAssertEqual(leg.toIATA, "DTW")
		XCTAssertEqual(leg.operatingAirlineIATA, "NW")
		XCTAssertEqual(leg.flightNumber, "0049")
		XCTAssertEqual(leg.dayOfYear, 228)
		XCTAssertEqual(leg.cabinCode, "F")
		XCTAssertEqual(leg.seatNumber, "001A")
		XCTAssertEqual(leg.checkinSequence, "0002")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 12)
		XCTAssertEqual(leg.documentNumber, "0987654321")
		XCTAssertEqual(leg.selectee, "0")
		XCTAssertEqual(leg.internationalDocumentVerification, "1")
		XCTAssertNil(leg.marketingAirlineIATA)
		XCTAssertNil(leg.frequentFlyerAirline)
		XCTAssertNil(leg.frequentFlyerNumber)
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "2PC")
		XCTAssertNil(leg.airlineData)
	}
}
