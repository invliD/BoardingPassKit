import Foundation

public class BPKFlightSegment {
    public var airlineData: Data?
    public var cabinCode: String
    public var checkinSequence: String
    public var dayOfYear: UInt32
    public var documentNumber: BPKDocumentNumber?
    public var fastTrack: Bool?
    public var flightNumber: String
    public var freeBaggageAllowance: String?
    public var frequentFlyerAirline: String?
    public var frequentFlyerNumber: String?
    public var fromIATA: String
    public var idAdIndicator: String?
    public var internationalDocumentVerification: String?
    public var marketingAirlineIATA: String?
    public var operatingAirlineIATA: String
    public var passengerStatus: String
    public var pnrCode: String
    public var seatNumber: String
    public var selectee: String?
    public var toIATA: String

    public init(data: Data) throws {
        let parser = BPKParser(data: data)

        pnrCode = try parser.readMandatoryString(7)
        fromIATA = try parser.readMandatoryString(3)
        toIATA = try parser.readMandatoryString(3)
        operatingAirlineIATA = try parser.readMandatoryString(3)
        flightNumber = try parser.readMandatoryString(5)
        dayOfYear = try parser.readMandatoryNumber(3)
        cabinCode = try parser.readMandatoryString(1)
        seatNumber = try parser.readMandatoryString(4)
        checkinSequence = try parser.readMandatoryString(5)
        passengerStatus = try parser.readMandatoryString(1)

		try parser.die()
    }

	public func parseConditionalFields(data: Data) throws {
		let parser = BPKParser(data: data)

		let maybeAirlineNumeric = try parser.readNumber(3)
		let maybeSerialNumber = try parser.readString(10)
		if let airlineNumeric = maybeAirlineNumeric, let serialNumber = maybeSerialNumber {
			documentNumber = BPKDocumentNumber(airlineNumeric: airlineNumeric, serialNumber: serialNumber)
		}
		selectee = try parser.readString(1)
		internationalDocumentVerification = try parser.readString(1)
		marketingAirlineIATA = try parser.readString(3)
		frequentFlyerAirline = try parser.readString(3)
		frequentFlyerNumber = try parser.readString(16)
		idAdIndicator = try parser.readString(1)
		freeBaggageAllowance = try parser.readString(3)
		// <v5 won't find fast track
		fastTrack = try parser.readBool()

		try parser.die()
	}
}
