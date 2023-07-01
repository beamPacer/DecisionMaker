//
//  BoundFloat.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

struct BoundFloat: Comparable, Codable, CustomStringConvertible {
	let maximumLimit: Float
	let minimumLimit: Float
	
	private var hiddenValue: Float
	
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
	
	var value: Float {
		get {
			return max(0, min(1, hiddenValue))
		}
		set {
			hiddenValue = newValue
		}
	}
	
	init(
		_ value: Float,
		minimumLimit: Float = 0,
		maximumLimit: Float = 1
		) {
		self.minimumLimit = minimumLimit
		self.maximumLimit = maximumLimit
		self.hiddenValue = value
	}
	
	static func < (lhs: BoundFloat, rhs: BoundFloat) -> Bool { lhs.value < rhs.value }
	
	var description: String { "\(value)" }
}

func +(lhs: BoundFloat, rhs: BoundFloat) -> BoundFloat { BoundFloat(lhs.value + rhs.value) }
func -(lhs: BoundFloat, rhs: BoundFloat) -> BoundFloat { BoundFloat(lhs.value - rhs.value) }
func *(lhs: BoundFloat, rhs: BoundFloat) -> BoundFloat { BoundFloat(lhs.value * rhs.value) }
func /(lhs: BoundFloat, rhs: BoundFloat) -> BoundFloat { BoundFloat(lhs.value / rhs.value) }
