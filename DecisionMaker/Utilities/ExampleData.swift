//
//  ExampleData.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/27/23.
//

import Foundation

struct ExampleData {
	static var buyingAHouse: Decision {
		var decision: Decision = Decision()
		
		let colorAttribute = StaticAttribute(
			title: Strings.ExampleData.BuyingAHouse.color,
			importance: Strings.ExampleData.BuyingAHouse.colorImportance,
			emoji: "🌈"
		)
		let priceAttribute = StaticAttribute(
			title: Strings.ExampleData.BuyingAHouse.price,
			importance: Strings.ExampleData.BuyingAHouse.priceImportance,
			emoji: "💰"
		)
		let locationAttribute = StaticAttribute(
			title: Strings.ExampleData.BuyingAHouse.location,
			importance: Strings.ExampleData.BuyingAHouse.locationImportance,
			emoji: "📍"
		)
		
		let option1 = Option(title: Strings.ExampleData.BuyingAHouse.Option1.title)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.colorGoodness
			),
			forStaticAttributeById: colorAttribute.id,
			optionAttributeById: option1.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.priceGoodness
			),
			forStaticAttributeById: priceAttribute.id,
			optionAttributeById: option1.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.locationGoodness
			),
			forStaticAttributeById: locationAttribute.id,
			optionAttributeById: option1.id
		)
		
		let option2 = Option(title: Strings.ExampleData.BuyingAHouse.Option2.title)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.colorGoodness
			),
			forStaticAttributeById: colorAttribute.id,
			optionAttributeById: option2.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.priceGoodness
			),
			forStaticAttributeById: priceAttribute.id,
			optionAttributeById: option2.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.locationGoodness
			),
			forStaticAttributeById: locationAttribute.id,
			optionAttributeById: option2.id
		)
		
		let option3 = Option(title: Strings.ExampleData.BuyingAHouse.Option3.title)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.colorGoodness
			),
			forStaticAttributeById: colorAttribute.id,
			optionAttributeById: option3.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.priceGoodness
			),
			forStaticAttributeById: priceAttribute.id,
			optionAttributeById: option3.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.locationGoodness
			),
			forStaticAttributeById: locationAttribute.id,
			optionAttributeById: option3.id
		)
		
		let option4 = Option(title: Strings.ExampleData.BuyingAHouse.Option4.title)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.colorGoodness
			),
			forStaticAttributeById: colorAttribute.id,
			optionAttributeById: option4.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.priceGoodness
			),
			forStaticAttributeById: priceAttribute.id,
			optionAttributeById: option4.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.locationGoodness
			),
			forStaticAttributeById: locationAttribute.id,
			optionAttributeById: option4.id
		)
		
		decision.staticAttributes = [
			colorAttribute,
			priceAttribute,
			locationAttribute
		]
		decision.options = [
			option1,
			option2,
			option3,
			option4
		]
		decision.title = Strings.ExampleData.BuyingAHouse.title
		
		return decision
	}
	
	static var minimumOptions: Decision {
		var decision: Decision = Decision()
		
		let oneAttribute = StaticAttribute(
			title: "oneAttribute",
			importance: BoundFloat(0.5)
		)
		
		let option1 = Option(title: "a")
		decision.setOptionAttribute(
			OptionAttribute(
				value: "oneAttributeValue1",
				goodness: BoundFloat(0.25)
			),
			forStaticAttributeById: oneAttribute.id,
			optionAttributeById: option1.id
		)
		
		let option2 = Option(title: "b")
		decision.setOptionAttribute(
			OptionAttribute(
				value: "oneAttributeValue2",
				goodness: BoundFloat(0.75)
			),
			forStaticAttributeById: oneAttribute.id,
			optionAttributeById: option2.id
		)
		
		decision.staticAttributes = [
			oneAttribute
		]
		decision.options = [
			option1,
			option2
		]
		decision.title = "minimumSetup"
		
		return decision
	}
	
	static var minimumOptions_greaterThan1Average: Decision {
		var decision: Decision = Decision()
		
		let attribute1 = StaticAttribute(
			title: "attribute1",
			importance: BoundFloat(1.0)
		)
		let attribute2 = StaticAttribute(
			title: "attribute2",
			importance: BoundFloat(0.5)
		)
		
		let option1 = Option(title: "a")
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value1",
				goodness: BoundFloat(1.0)
			),
			forStaticAttributeById: attribute1.id,
			optionAttributeById: option1.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value1",
				goodness: BoundFloat(0.5)
			),
			forStaticAttributeById: attribute2.id,
			optionAttributeById: option1.id
		)
		
		let option2 = Option(title: "b")
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value2",
				goodness: BoundFloat(0.75)
			),
			forStaticAttributeById: attribute1.id,
			optionAttributeById: option2.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value2",
				goodness: BoundFloat(0.75)
			),
			forStaticAttributeById: attribute2.id,
			optionAttributeById: option2.id
		)
		
		return Decision(
			staticAttributes: [
				attribute1,
				attribute2
			],
			options: [
				option1,
				option2
			],
			title: "minimumSetup"
		)
	}
	
	static var minimumOptions_allZero: Decision {
		var decision: Decision = Decision()
		
		let attribute1 = StaticAttribute(
			title: "attribute1",
			importance: BoundFloat(0.0)
		)
		let attribute2 = StaticAttribute(
			title: "attribute2",
			importance: BoundFloat(0.0)
		)
		
		var option1 = Option(title: "a")
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value1",
				goodness: BoundFloat(0.0)
			),
			forStaticAttributeById: attribute1.id,
			optionAttributeById: option1.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value1",
				goodness: BoundFloat(0.0)
			),
			forStaticAttributeById: attribute2.id,
			optionAttributeById: option1.id
		)
		
		var option2 = Option(title: "b")
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value2",
				goodness: BoundFloat(0.0)
			),
			forStaticAttributeById: attribute1.id,
			optionAttributeById: option2.id
		)
		decision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value2",
				goodness: BoundFloat(0.0)
			),
			forStaticAttributeById: attribute2.id,
			optionAttributeById: option2.id
		)
		
		decision.staticAttributes = [
			attribute1,
			attribute2
		]
		decision.options = [
			option1,
			option2
		]
		decision.title = "minimumSetup"
		
		return decision
	}
}
