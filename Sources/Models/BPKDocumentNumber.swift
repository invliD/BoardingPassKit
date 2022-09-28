import Foundation

public class BPKDocumentNumber {
	public static let numericFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.minimumIntegerDigits = 3
		return formatter
	}()

	public var airlineNumeric: UInt32
	public var serialNumber: String

	public var description: String {
		let paddedAirline = BPKDocumentNumber.numericFormatter.string(from: NSNumber(value: airlineNumeric))!
		return "\(paddedAirline)-\(serialNumber)"
	}

	public init?(airlineNumeric: UInt32, serialNumber: String) {
		guard airlineNumeric < 1000, serialNumber.count == 10 else {
			return nil
		}
		self.airlineNumeric = airlineNumeric
		self.serialNumber  = serialNumber
	}

	public convenience init?(string: String) {
		let cleanedString = string.replacingOccurrences(of: "-", with: "")
		guard cleanedString.count > 0 else {
			return nil
		}
		let numberStartIndex = cleanedString.index(cleanedString.startIndex, offsetBy: min(cleanedString.count, 3))
		let airline = cleanedString[..<numberStartIndex]
		let number = String(cleanedString[numberStartIndex...])
		guard let airlineNumeric = UInt32(airline) else {
			return nil
		}
		self.init(airlineNumeric: airlineNumeric, serialNumber: number)
	}
}

extension BPKDocumentNumber: Equatable {
	public static func == (lhs: BPKDocumentNumber, rhs: BPKDocumentNumber) -> Bool {
		return lhs.airlineNumeric == rhs.airlineNumeric && lhs.serialNumber == rhs.serialNumber
	}
}
