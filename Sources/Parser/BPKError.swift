import Foundation

public enum BPKError: Error {
	case cannotParseBool(String)
	case cannotParseNumber(String)
	case cannotParseString(Data)
	case mandatoryFieldBlank
	case noMoreData
	case tooMuchData(Int)

	case invalidFormatCode(String)
	case invalidSecurityIndicator(String)
	case invalidVersionNumberIndicator(String)
	case unsupportedVersion(String)
}
