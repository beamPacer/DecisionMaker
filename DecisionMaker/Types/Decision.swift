//
//  Types.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

struct Decision: Codable {
	@State var staticAttributes: [StaticAttribute] = []
	@State var options: [Option] = []
	@State var optionAttributes: [OptionAttribute] = []
	@State var title: String = ""
	var id = UUID()
	
	init(staticAttributes: [StaticAttribute] = [], options: [Option] = [], title: String = "") {
		self.staticAttributes = staticAttributes
		self.options = options
		self.title = title
	}

	func addAttribute(_ attribute: StaticAttribute) {
		self.staticAttributes.append(attribute)
	}

	func addOption(_ option: Option) {
		self.options.append(option)
	}

	mutating func getResults() -> [Result] {
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
	
	mutating func getWeightedAverage(for option: Option) -> Float {
		var weightedAverage: Float = 0
		
		for staticAttribute in staticAttributes {
			let optionAttribute: OptionAttribute = getOptionAttribute(forStaticAttributeById: staticAttribute.id, optionAttributeById: option.id)
			
			let weight: Float = staticAttribute.importance.value
			weightedAverage = weightedAverage + ((optionAttribute.goodness.value) * weight)
		}
		
		return weightedAverage
	}
	
	mutating func getOptionAttribute(
		forStaticAttributeById staticAttributeId: UUID,
		optionAttributeById optionAttributeId: UUID
	) -> OptionAttribute {
		if optionAttributes.first(where: { $0.optionId == optionAttributeId && $0.staticAttributeId == staticAttributeId }) == nil {
			optionAttributes.append(OptionAttribute())
		}

		guard let optionAttribute = optionAttributes.first(where: { $0.optionId == optionAttributeId && $0.staticAttributeId == staticAttributeId }) else {
			return OptionAttribute()
		}

		return optionAttribute
	}

	mutating func setOptionAttribute(
		_ optionAttribute: OptionAttribute,
		forStaticAttributeById staticAttributeId: UUID,
		optionAttributeById optionAttributeId: UUID
	) {
		optionAttributes = optionAttributes.map { iteratedOptionAttribute in
			if iteratedOptionAttribute.optionId == optionAttributeId,
			   iteratedOptionAttribute.staticAttributeId == staticAttributeId {
				return optionAttribute
			} else {
				return iteratedOptionAttribute
			}
		}
	}

	mutating func setOptionAttributeGoodness(
		_ goodness: BoundFloat,
		forStaticAttributeById staticAttributeId: UUID,
		optionAttributeById optionAttributeId: UUID
	) {
		let optionAttribute = getOptionAttribute(
			forStaticAttributeById: staticAttributeId,
			optionAttributeById: optionAttributeId
		)
		optionAttribute.goodness = goodness
		setOptionAttribute(
			optionAttribute,
			forStaticAttributeById: staticAttributeId,
			optionAttributeById: optionAttributeId
		)
	}
}

// MARK: Codable conformance

extension Decision {
	enum CodingKeys: CodingKey {
		case staticAttributes, options, title, id
	}
	
	init(from decoder: Decoder) throws {
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

//extension Decision: CustomStringConvertible {
//	var description: String {
//		var returnString: String = "Static attributes:\n"
//		for staticAttribute in staticAttributes {
//			returnString += staticAttribute.description
//			returnString += "\n"
//		}
//		
//		returnString += "Option attributes:\n"
//		
//		for option in options {
//			returnString += option.description
//			returnString += "\n"
//			for staticAttribute in staticAttributes {
//				returnString += staticAttribute.description
//				returnString += ": "
//				returnString += getOptionAttribute(forStaticAttributeById: staticAttribute.id, optionAttributeById: option.id).description
//				returnString += "\n"
//			}
//		}
//		
//		return returnString
//	}
//}

