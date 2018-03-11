import BoardingPassKit
import XCTest

class BoardingPassExamplev5Tests: XCTestCase {
	private let securityData = "GIWVC5EH7JNT684FVNJ91W2QA4DVN5J8K4F0L0GEQ3DF5TGBN8709HKT5D3DW3GBHFCVHMY7J5T6HFR41W2QA4DVN5J8K4F0L0GE"
		.data(using: .ascii)!

	// example 1 has not changed since v4

	func testExample2() throws {
		let data = "M1DESMARAIS/LUC       EAB12C3 YULFRAAC 0834 326J003A0027 167>5321WW1325BAC 0014123456002001412346700100141234789012A0141234567890 1AC AC 1234567890123    4PCYLX58Z^164".data(using: .ascii)! + securityData
		let boardingPass = try BPKBoardingPass(data: data)
		XCTAssertEqual(boardingPass.legs.count, 1)
		XCTAssertEqual(boardingPass.firstName, "LUC")
		XCTAssertEqual(boardingPass.lastName, "DESMARAIS")
		XCTAssertEqual(boardingPass.securityType, "1")
		XCTAssertEqual(boardingPass.securityData, securityData)

		XCTAssertEqual(boardingPass.passengerDescription, "1")
		XCTAssertEqual(boardingPass.checkinSource, "W")
		XCTAssertEqual(boardingPass.boardingPassSource, "W")
		XCTAssertEqual(boardingPass.boardingPassIssueYear, 1)
		XCTAssertEqual(boardingPass.boardingPassIssueDay, 325)
		XCTAssertEqual(boardingPass.documentType, "B")
		XCTAssertEqual(boardingPass.boardingPassIssuer, "AC")

		XCTAssertEqual(boardingPass.baggageTagRanges.count, 3)
		var tagRange = boardingPass.baggageTagRanges[0]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 14)
		XCTAssertEqual(tagRange.numberRange, 123456...123458)
		tagRange = boardingPass.baggageTagRanges[1]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 14)
		XCTAssertEqual(tagRange.numberRange, 123467...123468)
		tagRange = boardingPass.baggageTagRanges[2]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 14)
		XCTAssertEqual(tagRange.numberRange, 123478...124379)

		let leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "AB12C3")
		XCTAssertEqual(leg.fromIATA, "YUL")
		XCTAssertEqual(leg.toIATA, "FRA")
		XCTAssertEqual(leg.operatingAirlineIATA, "AC")
		XCTAssertEqual(leg.flightNumber, "0834")
		XCTAssertEqual(leg.dayOfYear, 326)
		XCTAssertEqual(leg.cabinCode, "J")
		XCTAssertEqual(leg.seatNumber, "003A")
		XCTAssertEqual(leg.checkinSequence, "0027")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 14)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertEqual(leg.internationalDocumentVerification, "1")
		XCTAssertEqual(leg.marketingAirlineIATA, "AC")
		XCTAssertEqual(leg.frequentFlyerAirline, "AC")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "4PC")
		XCTAssertTrue(leg.fastTrack!)
		XCTAssertEqual(leg.airlineData, "LX58Z".data(using: .ascii)!)
	}

	func testExample3() throws {
		let data = "M1GRANDMAIRE/MELANIE  EABC123 GVACDGAF 0123 339C002F0025 130>5002A0571234567890  AF AF 1234567890123456    Y^164"
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
		XCTAssertEqual(leg.dayOfYear, 339)
		XCTAssertEqual(leg.cabinCode, "C")
		XCTAssertEqual(leg.seatNumber, "002F")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 57)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertNil(leg.internationalDocumentVerification)
		XCTAssertEqual(leg.marketingAirlineIATA, "AF")
		XCTAssertEqual(leg.frequentFlyerAirline, "AF")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123456")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertNil(leg.freeBaggageAllowance)
		XCTAssertTrue(leg.fastTrack!)
		XCTAssertNil(leg.airlineData)
	}

	func testExample4() throws {
		let data = "M2DESMARAIS/LUC       EABC123 YULFRAAC 0834 326J003A0027 15A>5251WW1325BAC 001412345600200141234670012A0141234567890 1AC AC 1234567890123    3PCYLX58ZDEF456 FRAGVALH 3664 327C012C0002 12E2A0140987654321 1AC AC 1234567890123    3PCNWQ^164"
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
		XCTAssertEqual(boardingPass.boardingPassIssueYear, 1)
		XCTAssertEqual(boardingPass.boardingPassIssueDay, 325)
		XCTAssertEqual(boardingPass.documentType, "B")
		XCTAssertEqual(boardingPass.boardingPassIssuer, "AC")

		XCTAssertEqual(boardingPass.baggageTagRanges.count, 2)
		var tagRange = boardingPass.baggageTagRanges[0]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 14)
		XCTAssertEqual(tagRange.numberRange, 123456...123458)
		tagRange = boardingPass.baggageTagRanges[1]
		XCTAssertEqual(tagRange.type, 0)
		XCTAssertEqual(tagRange.airlineNumeric, 14)
		XCTAssertEqual(tagRange.numberRange, 123467...123468)

		var leg = boardingPass.legs[0]
		XCTAssertEqual(leg.pnrCode, "ABC123")
		XCTAssertEqual(leg.fromIATA, "YUL")
		XCTAssertEqual(leg.toIATA, "FRA")
		XCTAssertEqual(leg.operatingAirlineIATA, "AC")
		XCTAssertEqual(leg.flightNumber, "0834")
		XCTAssertEqual(leg.dayOfYear, 326)
		XCTAssertEqual(leg.cabinCode, "J")
		XCTAssertEqual(leg.seatNumber, "003A")
		XCTAssertEqual(leg.checkinSequence, "0027")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 14)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertEqual(leg.internationalDocumentVerification, "1")
		XCTAssertEqual(leg.marketingAirlineIATA, "AC")
		XCTAssertEqual(leg.frequentFlyerAirline, "AC")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "3PC")
		XCTAssertTrue(leg.fastTrack!)
		XCTAssertEqual(leg.airlineData, "LX58Z".data(using: .ascii)!)

		leg = boardingPass.legs[1]
		XCTAssertEqual(leg.pnrCode, "DEF456")
		XCTAssertEqual(leg.fromIATA, "FRA")
		XCTAssertEqual(leg.toIATA, "GVA")
		XCTAssertEqual(leg.operatingAirlineIATA, "LH")
		XCTAssertEqual(leg.flightNumber, "3664")
		XCTAssertEqual(leg.dayOfYear, 327)
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
		XCTAssertEqual(leg.freeBaggageAllowance, "3PC")
		XCTAssertFalse(leg.fastTrack!)
		XCTAssertEqual(leg.airlineData, "WQ".data(using: .ascii)!)
	}

	func testExample5() throws {
		let data = "M2GRANDMAIRE/MELANIE  EABC123 GVACDGAF 0123 339C002F0025 130>5002A0571234567890  AF AF 1234567890123456 20KYDEF456 CDGDTWNW 0049 339F001A0002 12C2A012098765432101                       2PC ^164"
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
		XCTAssertEqual(leg.dayOfYear, 339)
		XCTAssertEqual(leg.cabinCode, "C")
		XCTAssertEqual(leg.seatNumber, "002F")
		XCTAssertEqual(leg.checkinSequence, "0025")
		XCTAssertEqual(leg.passengerStatus, "1")

		XCTAssertEqual(leg.documentAirlineNumeric, 57)
		XCTAssertEqual(leg.documentNumber, "1234567890")
		XCTAssertNil(leg.selectee)
		XCTAssertNil(leg.internationalDocumentVerification)
		XCTAssertEqual(leg.marketingAirlineIATA, "AF")
		XCTAssertEqual(leg.frequentFlyerAirline, "AF")
		XCTAssertEqual(leg.frequentFlyerNumber, "1234567890123456")
		XCTAssertNil(leg.idAdIndicator)
		XCTAssertEqual(leg.freeBaggageAllowance, "20K")
		XCTAssertTrue(leg.fastTrack!)
		XCTAssertNil(leg.airlineData)

		leg = boardingPass.legs[1]
		XCTAssertEqual(leg.pnrCode, "DEF456")
		XCTAssertEqual(leg.fromIATA, "CDG")
		XCTAssertEqual(leg.toIATA, "DTW")
		XCTAssertEqual(leg.operatingAirlineIATA, "NW")
		XCTAssertEqual(leg.flightNumber, "0049")
		XCTAssertEqual(leg.dayOfYear, 339)
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
		XCTAssertNil(leg.fastTrack)
		XCTAssertNil(leg.airlineData)
	}
}
