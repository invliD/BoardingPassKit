class BPKParser {
	private var cursor = 0
	private var data: Data

	public var remaining: Int {
		return data.count - cursor
	}

	public init(data: Data) {
		self.data = data
	}

	public func skip(_ length: Int) {
		cursor += length
	}

	public func readMandatoryString(_ length: Int) throws -> String {
		guard let str = try readString(length) else {
			throw BPKError.mandatoryFieldBlank
		}
		return str
	}

	public func readString(_ length: Int) throws -> String? {
		guard let data = try getSubData(length) else {
			return nil
		}
		guard let rawString = String(data: data, encoding: String.Encoding.ascii) else {
			throw BPKError.cannotParseString(data)
		}
		let trimmedString = rawString.trimmingCharacters(in: CharacterSet.whitespaces)
		return trimmedString.count == 0 ? nil : trimmedString
	}

	public func readBool() throws -> Bool? {
		guard let str = try readString(1) else {
			return nil
		}
		if str == "Y" {
			return true
		} else if str == "N" {
			return false
		} else {
			throw BPKError.cannotParseBool(str)
		}
	}

	public func readMandatoryNumber(_ length: Int) throws -> UInt32 {
		let rawString = try readString(length)
		guard let str = rawString else {
			throw BPKError.mandatoryFieldBlank
		}
		guard let number = UInt32(str) else {
			throw BPKError.cannotParseNumber(str)
		}
		return number
	}

	public func readNumber(_ length: Int) throws -> UInt32? {
		let rawString = try readString(length)
		guard let str = rawString else {
			return nil
		}
		guard let number = UInt32(str) else {
			throw BPKError.cannotParseNumber(str)
		}
		return number
	}

	public func readMandatoryHexNumber(_ length: Int) throws -> UInt32 {
		let rawString = try readString(length)
		guard let str = rawString else {
			throw BPKError.mandatoryFieldBlank
		}
		guard let number = UInt32(str, radix: 16) else {
			throw BPKError.cannotParseNumber(str)
		}
		return number
	}

	public func getSubParser(_ length: Int) throws -> BPKParser {
		return BPKParser(data: try getMandatorySubData(length))
	}

	public func getMandatorySubData(_ length: Int) throws -> Data {
		if (data.count < cursor + length) {
			throw BPKError.noMoreData
		}
		let subdata = data.subdata(in: cursor ..< (cursor + length))
		cursor += length
		return subdata
	}

	public func getSubData(_ length: Int) throws -> Data? {
		if (data.count < cursor + length) {
			return nil
		}
		let subdata = data.subdata(in: cursor ..< (cursor + length))
		cursor += length
		return subdata
	}

	public func die() throws {
		if remaining > 0 {
			throw BPKError.tooMuchData(remaining)
		}
	}
}
