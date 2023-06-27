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

class DecisionData: ObservableObject {
	@Published var decisions: [Decision] = []
}

class Decision: CustomStringConvertible, ObservableObject {
	@Published var staticAttributes: [StaticAttribute] = []
	@Published var options: [Option] = []
	@Published var title: String = ""
	
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
	
	func getResults() -> [Option] {
		return options.sorted {
			var weightedAverage1: BoundFloat = BoundFloat(0)
			var weightedAverage2: BoundFloat = BoundFloat(0)
			
			for staticAttribute in staticAttributes {
				let optionAttribute1: OptionAttribute = $0.getOptionAttribute(for: staticAttribute)
				let optionAttribute2: OptionAttribute = $1.getOptionAttribute(for: staticAttribute)
				
				let weight: BoundFloat = staticAttribute.importance
				weightedAverage1 = weightedAverage1 + ((optionAttribute1.goodness) * weight)
				weightedAverage2 = weightedAverage2 + ((optionAttribute2.goodness) * weight)
			}
			
			return weightedAverage1 > weightedAverage2
		}
	}
}

class StaticAttribute: Hashable, CustomStringConvertible, ObservableObject, Identifiable {
	var id = UUID()
	
	@Published var title: String
	@Published var importance: BoundFloat
	
	init(title: String = "", importance: BoundFloat = BoundFloat(0)) {
		self.title = title
		self.importance = importance
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

class OptionAttribute: CustomStringConvertible {
	@Published var value: String = ""
	@Published var goodness: BoundFloat = BoundFloat(0)
	
	var description: String {
		"OptionAttribute("
		+ "\"\(value)\""
		+ ", "
		+ "\(goodness.description)"
		+ ")"
	}
}

class Option: CustomStringConvertible, ObservableObject, Hashable, Identifiable {
	var id = UUID()
	@Published var title: String
	
	private var map: [StaticAttribute: OptionAttribute] = [:]
	
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

struct BoundFloat: Comparable, CustomStringConvertible {
	let maximumLimit: Float
	let minimumLimit: Float
	
	private var hiddenValue: Float
	
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
