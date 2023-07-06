//
//  BoundFloat.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

struct BoundFloat {
	let maximumLimit: Float
	let minimumLimit: Float
	
	private var hiddenValue: Float

	init(
		_ value: Float,
		minimumLimit: Float = 0,
		maximumLimit: Float = 1
		) {
		self.minimumLimit = minimumLimit
		self.maximumLimit = maximumLimit
		self.hiddenValue = value
	}
	
	var value: Float {
		get {
			return max(0, min(1, hiddenValue))
		}
		set {
			hiddenValue = newValue
		}
	}
}

// MARK: Comparable conformance

extension BoundFloat: Comparable {
	static func < (lhs: BoundFloat, rhs: BoundFloat) -> Bool { lhs.value < rhs.value }
}

// MARK: Codable conformance

extension BoundFloat: Codable {
	enum CodingKeys: CodingKey {
		case maximumLimit, minimumLimit, hiddenValue
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		maximumLimit = try container.decode(Float.self, forKey: .maximumLimit)
		minimumLimit = try container.decode(Float.self, forKey: .minimumLimit)
		hiddenValue = try container.decode(Float.self, forKey: .hiddenValue)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(maximumLimit, forKey: .maximumLimit)
		try container.encode(minimumLimit, forKey: .minimumLimit)
		try container.encode(hiddenValue, forKey: .hiddenValue)
	}
}

// MARK: CustomStringConvertible conformance

extension BoundFloat: CustomStringConvertible {
	var description: String { "\(value)" }
}
