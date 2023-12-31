//
//  Types.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import Foundation

class Decision: ObservableObject, Codable {
	@Published var staticAttributes: [StaticAttribute] = []
	@Published var options: [Option] = []
	@Published var title: String = ""
	var id = UUID()
	
	init(staticAttributes: [StaticAttribute] = [], options: [Option] = [], title: String = "") {
		self.staticAttributes = staticAttributes
		self.options = options
		self.title = title
	}

	func addAttribute(_ attribute: StaticAttribute) {
		self.staticAttributes.append(attribute)
		self.objectWillChange.send()
	}

	func addOption(_ option: Option) {
		self.options.append(option)
		self.objectWillChange.send()
	}

	func getResults() -> [Result] {
		let returnValue: [Result] = options.map {
			Result(
				option: $0,
				weightedAverage: getWeightedAverage(for: $0),
				percentWeightedAverage: 0.0
			)
		}
		.sorted { $0.weightedAverage > $1.weightedAverage }
		
		var max: Float = 0
		returnValue.forEach {
			if $0.weightedAverage > max {
				max = $0.weightedAverage
			}
		}
		
		return returnValue.map {
			Result(
				option: $0.option,
				weightedAverage: $0.weightedAverage,
				percentWeightedAverage: max != 0 ? $0.weightedAverage / max : 0
			)
		}
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
	
	// MARK: Codable conformance
	
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
}

// MARK: CustomStringConvertible conformance

extension Decision: CustomStringConvertible {
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
}

