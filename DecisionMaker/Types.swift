//
//  Types.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import Foundation

/*
 This code models making a decision using weighted average. Decisions have
 static attributes and they have options. Attributes of those options are stored
 by each option; each option holds a map that maps static attributes to option
 attributes. For this static attribute, here's the option attribute. The
 initialization of the option attributes map in each option is lazy.
 
 [ Decision ]------> [ StaticAttribute ]
   |                        |
   V                        V
 [ Option ] <----> [ OptionAttribute ]
 */

class DecisionData: ObservableObject, Codable {
	@Published var decisions: [Decision] = []

	enum CodingKeys: CodingKey {
		case decisions
	}
	
	init() { decisions = [] }
	init(_ decision: Decision) { self.decisions = [decision] }
	init(_ decisions: [Decision]) { self.decisions = decisions }

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		decisions = try container.decode([Decision].self, forKey: .decisions)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(decisions, forKey: .decisions)
	}
}

class Decision: ObservableObject, Codable, CustomStringConvertible {
	@Published var staticAttributes: [StaticAttribute] = []
	@Published var options: [Option] = []
	@Published var title: String = ""
	var id = UUID()
	
	init(staticAttributes: [StaticAttribute] = [], options: [Option] = [], title: String = "") {
		self.staticAttributes = staticAttributes
		self.options = options
		self.title = title
	}

	enum CodingKeys: CodingKey {
		case staticAttributes, options, title, id
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		staticAttributes = try container.decode([StaticAttribute].self, forKey: .staticAttributes)
		options = try container.decode([Option].self, forKey: .options)
		title = try container.decode(String.self, forKey: .title)
		id = try container.decode(UUID.self, forKey: .id)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(staticAttributes, forKey: .staticAttributes)
		try container.encode(options, forKey: .options)
		try container.encode(title, forKey: .title)
		try container.encode(id, forKey: .id)
	}
	
	func addAttribute(_ attribute: StaticAttribute) {
		self.staticAttributes.append(attribute)
		self.objectWillChange.send()
	}

	func addOption(_ option: Option) {
		self.options.append(option)
		self.objectWillChange.send()
	}
	
	var description: String {
		var returnString: String = "Static attributes:\n"
		for staticAttribute in staticAttributes {
			returnString += staticAttribute.description
			returnString += "\n"
		}
		
		returnString += "Option attributes:\n"
		
		for option in options {
			returnString += option.description
			returnString += "\n"
			for staticAttribute in staticAttributes {
				returnString += staticAttribute.description
				returnString += ": "
				returnString += option.getOptionAttribute(for: staticAttribute).description
				returnString += "\n"
			}
		}
		
		return returnString
	}
	
	func getResults() -> [Result] {
		return options.map {
			Result(
				option: $0,
				weightedAverage: getWeightedAverage(for: $0)
			)
		}
		.sorted { $0.weightedAverage > $1.weightedAverage }
	}
	
	func getWeightedAverage(for option: Option) -> Float {
		var weightedAverage: Float = 0
		
		for staticAttribute in staticAttributes {
			let optionAttribute: OptionAttribute = option.getOptionAttribute(for: staticAttribute)
			
			let weight: Float = staticAttribute.importance.value
			weightedAverage = weightedAverage + ((optionAttribute.goodness.value) * weight)
		}
		
		return weightedAverage
	}
}

struct Result: Hashable {
	let option: Option
	let weightedAverage: Float
}

class StaticAttribute: ObservableObject, Codable, Identifiable, Hashable, CustomStringConvertible {
	var id = UUID()
	@Published var title: String
	@Published var importance: BoundFloat
	var emoji: String

	enum CodingKeys: CodingKey {
		case id, title, importance, emoji
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		importance = try container.decode(BoundFloat.self, forKey: .importance)
		do {
			emoji = try container.decode(String.self, forKey: .emoji)
		} catch {
			emoji = Strings.Common.defaultEmoji
		}
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(importance, forKey: .importance)
		try container.encode(emoji, forKey: .emoji)
	}
	
	init(title: String = "", importance: BoundFloat = BoundFloat(0), emoji: String? = nil) {
		self.title = title
		self.importance = importance
		self.emoji = emoji != nil ? emoji! : EmojiHandler.shared.emoji(for: title) ?? Strings.Common.defaultEmoji
	}
	
	var description: String {
		"StaticAttribute("
		+ "\"\(title)\""
		+ ", "
		+ "\(importance.description)"
		+ ")"
	}
	
	static func == (lhs: StaticAttribute, rhs: StaticAttribute) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

class OptionAttribute: ObservableObject, Codable, CustomStringConvertible {
	@Published var value: String = ""
	@Published var goodness: BoundFloat = BoundFloat(0)
	
	init(value: String = "", goodness: BoundFloat = BoundFloat(0)) {
		self.value = value
		self.goodness = goodness
	}
	
	enum CodingKeys: CodingKey {
		case value, goodness
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		value = try container.decode(String.self, forKey: .value)
		goodness = try container.decode(BoundFloat.self, forKey: .goodness)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(value, forKey: .value)
		try container.encode(goodness, forKey: .goodness)
	}
	
	var description: String {
		"OptionAttribute("
		+ "\"\(value)\""
		+ ", "
		+ "\(goodness.description)"
		+ ")"
	}
}

class Option: ObservableObject, Codable, CustomStringConvertible, Hashable, Identifiable {
	var id = UUID()
	@Published var title: String
	
	private var map: [StaticAttribute: OptionAttribute] = [:]
	
	enum CodingKeys: CodingKey {
		case id, title, map
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		map = try container.decode([StaticAttribute: OptionAttribute].self, forKey: .map)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(map, forKey: .map)
	}
	
	init(title: String = "") {
		self.title = title
	}
	
	var description: String {
		return "Option(\"\(title)\")"
	}
	
	static func == (lhs: Option, rhs: Option) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	func getOptionAttributes() -> [OptionAttribute] { Array(map.values) }
	
	func getOptionAttribute(for staticAttribute: StaticAttribute) -> OptionAttribute {
		if map[staticAttribute] == nil {
			map[staticAttribute] = OptionAttribute()
		}
		
		// For the compiler
		guard let optionAttribute = map[staticAttribute] else {
			return OptionAttribute()
		}
		
		return optionAttribute
	}
	
	func setOptionAttribute(
		_ optionAttribute: OptionAttribute,
		for staticAttribute: StaticAttribute
	) {
		map[staticAttribute] = optionAttribute
	}
	
	func setOptionAttributeGoodness(
		_ goodness: BoundFloat,
		for staticAttribute: StaticAttribute
	) {
		let optionAttribute = getOptionAttribute(for: staticAttribute)
		optionAttribute.goodness = goodness
		setOptionAttribute(optionAttribute, for: staticAttribute)
	}
}

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
