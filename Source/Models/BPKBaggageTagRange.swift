public class BPKBaggageTagRange {
	public var type: UInt32
	public var airlineNumeric: UInt32
	public var numberRange: ClosedRange<UInt32>

	public init(data: Data) throws {
		let parser = BPKParser(data: data)
		type = try parser.readMandatoryNumber(1)
		airlineNumeric = try parser.readMandatoryNumber(3)
		let numberStart = try parser.readMandatoryNumber(6)
		let numbers = try parser.readMandatoryNumber(3)
		numberRange = numberStart ... (numberStart + numbers)
		try parser.die()
	}
}
