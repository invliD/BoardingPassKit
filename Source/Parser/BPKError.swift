enum BPKError: Error {
	case cannotParseBool
	case cannotParseNumber
	case cannotParseString
	case mandatoryFieldBlank
	case noMoreData
	case tooMuchData

	case invalidFormatCode
	case invalidSecurityIndicator
	case invalidVersionNumberIndicator
	case unsupportedVersion
}
