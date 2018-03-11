public class BPKBoardingPass {
	public var baggageTagRanges: [BPKBaggageTagRange] = []
	public var boardingPassIssueYear: UInt32?
	public var boardingPassIssueDay: UInt32?
	public var boardingPassIssuer: String?
	public var boardingPassSource: String?
	public var checkinSource: String?
	public var documentType: String?
	public var firstName: String?
	public var lastName: String
	public var legs: [BPKFlightSegment] = []
	public var passengerDescription: String?
	public var securityType: String?
	public var securityData: Data?

	public init(data: Data) throws {
		let parser = BPKParser(data: data)

		let formatCode = try parser.readMandatoryString(1)
		guard formatCode == "M" else {
			throw BPKError.invalidFormatCode(formatCode)
		}

		let numberOfLegs = try parser.readMandatoryNumber(1)

		let passengerName = try parser.readMandatoryString(20)
		let names = passengerName.split(separator: "/")
		// TODO fix case
		lastName = String(names[0])
		if names.count > 1 {
			firstName = String(names[1])
		}

		// Don't care about e ticket indicator
		parser.skip(1)

		for i in 1...numberOfLegs {
			let mandatoryData = try parser.getMandatorySubData(35)
			let leg = try BPKFlightSegment(data: mandatoryData)
			let conditionalLength = try parser.readMandatoryHexNumber(2)
			if conditionalLength > 0 {
				let conditionalParser = try parser.getSubParser(Int(conditionalLength))
				// parse unique fields in first segment only
				if i == 1 {
					let versionNumberIndicator = try conditionalParser.readMandatoryString(1)
					guard versionNumberIndicator == ">" else {
						throw BPKError.invalidVersionNumberIndicator(versionNumberIndicator)
					}
					let version = try conditionalParser.readMandatoryString(1)
					guard ["3", "4", "5", "6"].contains(version) else {
						throw BPKError.unsupportedVersion(version)
					}

					let conditionalUniqueLength = try conditionalParser.readMandatoryHexNumber(2)
					let conditionalUniqueData = try conditionalParser.getMandatorySubData(Int(conditionalUniqueLength))
					try parseConditionalFields(data: conditionalUniqueData)
				}

				let conditionalRepeatedLength = try conditionalParser.readMandatoryHexNumber(2)
				let conditionalRepeatedData = try conditionalParser.getMandatorySubData(Int(conditionalRepeatedLength))
				try leg.parseConditionalFields(data: conditionalRepeatedData)
				if (conditionalParser.remaining > 0) {
					leg.airlineData = try conditionalParser.getMandatorySubData(conditionalParser.remaining)
				}
			}
			legs.append(leg)
		}

		if parser.remaining > 0 {
			// parse unique fields in first segment only
			let securityIndicator = try parser.readMandatoryString(1)
			guard securityIndicator == "^" else {
				throw BPKError.invalidSecurityIndicator(securityIndicator)
			}
			securityType = try parser.readMandatoryString(1)
			let securityLength = try parser.readMandatoryHexNumber(2)
			securityData = try parser.getMandatorySubData(Int(securityLength))

			try parser.die()
		}
	}

	private func parseConditionalFields(data: Data) throws {
		let parser = BPKParser(data: data)
		passengerDescription = try parser.readString(1)
		checkinSource = try parser.readString(1)
		boardingPassSource = try parser.readString(1)
		boardingPassIssueYear = try parser.readNumber(1)
		boardingPassIssueDay = try parser.readNumber(3)
		documentType = try parser.readString(1)
		boardingPassIssuer = try parser.readString(3)

		// <v4 will only find the first baggage tag range
		baggageTagRanges = []
		for _ in 1...3 {
			guard let tagData = try parser.getSubData(13) else {
				break
			}
			guard let tagRange = try BPKBaggageTagRange(data: tagData) else {
				continue
			}
			baggageTagRanges.append(tagRange)
		}

		try parser.die()
	}
}
