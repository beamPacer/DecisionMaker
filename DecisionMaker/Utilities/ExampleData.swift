//
//  ExampleData.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/27/23.
//

import Foundation

struct ExampleData {
	static var buyingAHouse: Decision {
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
		
		var option1 = Option(title: Strings.ExampleData.BuyingAHouse.Option1.title)
		option1.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.colorGoodness
			),
			for: colorAttribute
		)
		option1.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.priceGoodness
			),
			for: priceAttribute
		)
		option1.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.locationGoodness
			),
			for: locationAttribute
		)
		
		var option2 = Option(title: Strings.ExampleData.BuyingAHouse.Option2.title)
		option2.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.colorGoodness
			),
			for: colorAttribute
		)
		option2.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.priceGoodness
			),
			for: priceAttribute
		)
		option2.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.locationGoodness
			),
			for: locationAttribute
		)
		
		var option3 = Option(title: Strings.ExampleData.BuyingAHouse.Option3.title)
		option3.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.colorGoodness
			),
			for: colorAttribute
		)
		option3.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.priceGoodness
			),
			for: priceAttribute
		)
		option3.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.locationGoodness
			),
			for: locationAttribute
		)
		
		var option4 = Option(title: Strings.ExampleData.BuyingAHouse.Option4.title)
		option4.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.colorGoodness
			),
			for: colorAttribute
		)
		option4.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.priceGoodness
			),
			for: priceAttribute
		)
		option4.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.locationGoodness
			),
			for: locationAttribute
		)
		
		return Decision(
			staticAttributes: [
				colorAttribute,
				priceAttribute,
				locationAttribute
			],
			options: [
				option1,
				option2,
				option3,
				option4
			],
			title: Strings.ExampleData.BuyingAHouse.title
		)
	}
	
	static var minimumOptions: Decision {
		let oneAttribute = StaticAttribute(
			title: "oneAttribute",
			importance: BoundFloat(0.5)
		)
		
		var option1 = Option(title: "a")
		option1.setOptionAttribute(
			OptionAttribute(
				value: "oneAttributeValue1",
				goodness: BoundFloat(0.25)
			),
			for: oneAttribute
		)
		
		var option2 = Option(title: "b")
		option2.setOptionAttribute(
			OptionAttribute(
				value: "oneAttributeValue2",
				goodness: BoundFloat(0.75)
			),
			for: oneAttribute
		)
		
		return Decision(
			staticAttributes: [
				oneAttribute
			],
			options: [
				option1,
				option2
			],
			title: "minimumSetup"
		)
	}
	
	static var minimumOptions_greaterThan1Average: Decision {
		let attribute1 = StaticAttribute(
			title: "attribute1",
			importance: BoundFloat(1.0)
		)
		let attribute2 = StaticAttribute(
			title: "attribute2",
			importance: BoundFloat(0.5)
		)
		
		var option1 = Option(title: "a")
		option1.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value1",
				goodness: BoundFloat(1.0)
			),
			for: attribute1
		)
		option1.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value1",
				goodness: BoundFloat(0.5)
			),
			for: attribute2
		)
		
		var option2 = Option(title: "b")
		option2.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value2",
				goodness: BoundFloat(0.75)
			),
			for: attribute1
		)
		option2.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value2",
				goodness: BoundFloat(0.75)
			),
			for: attribute2
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
		let attribute1 = StaticAttribute(
			title: "attribute1",
			importance: BoundFloat(0.0)
		)
		let attribute2 = StaticAttribute(
			title: "attribute2",
			importance: BoundFloat(0.0)
		)
		
		var option1 = Option(title: "a")
		option1.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value1",
				goodness: BoundFloat(0.0)
			),
			for: attribute1
		)
		option1.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value1",
				goodness: BoundFloat(0.0)
			),
			for: attribute2
		)
		
		var option2 = Option(title: "b")
		option2.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value2",
				goodness: BoundFloat(0.0)
			),
			for: attribute1
		)
		option2.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value2",
				goodness: BoundFloat(0.0)
			),
			for: attribute2
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
}
