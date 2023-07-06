//
//  ExampleData.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/27/23.
//

import Foundation

struct ExampleData {
	static var buyingAHouse: Decision {
		let returnDecision: Decision = Decision()
		
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
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.colorGoodness
			),
			forOptionID: option1.id,
			staticAttributeId: colorAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.priceGoodness
			),
			forOptionID: option1.id,
			staticAttributeId: priceAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option1.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option1.locationGoodness
			),
			forOptionID: option1.id,
			staticAttributeId: locationAttribute.id
		)
		
		let option2 = Option(title: Strings.ExampleData.BuyingAHouse.Option2.title)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.colorGoodness
			),
			forOptionID: option2.id,
			staticAttributeId: colorAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.priceGoodness
			),
			forOptionID: option2.id,
			staticAttributeId: priceAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option2.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option2.locationGoodness
			),
			forOptionID: option2.id,
			staticAttributeId: locationAttribute.id
		)
		
		let option3 = Option(title: Strings.ExampleData.BuyingAHouse.Option3.title)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.colorGoodness
			),
			forOptionID: option3.id,
			staticAttributeId: colorAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.priceGoodness
			),
			forOptionID: option3.id,
			staticAttributeId: priceAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option3.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option3.locationGoodness
			),
			forOptionID: option3.id,
			staticAttributeId: locationAttribute.id
		)
		
		let option4 = Option(title: Strings.ExampleData.BuyingAHouse.Option4.title)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.color,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.colorGoodness
			),
			forOptionID: option4.id,
			staticAttributeId: colorAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.price,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.priceGoodness
			),
			forOptionID: option4.id,
			staticAttributeId: priceAttribute.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: Strings.ExampleData.BuyingAHouse.Option4.location,
				goodness: Strings.ExampleData.BuyingAHouse.Option4.locationGoodness
			),
			forOptionID: option4.id,
			staticAttributeId: locationAttribute.id
		)
		
		returnDecision.staticAttributes = [
			colorAttribute,
			priceAttribute,
			locationAttribute
		]
		returnDecision.options = [
			option1,
			option2,
			option3,
			option4
		]
		returnDecision.title = Strings.ExampleData.BuyingAHouse.title
		
		return returnDecision
	}
	
	static var minimumOptions: Decision {
		let returnDecision: Decision = Decision()
		
		let oneAttribute = StaticAttribute(
			title: "oneAttribute",
			importance: BoundFloat(0.5)
		)
		
		let option1 = Option(title: "a")
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "oneAttributeValue1",
				goodness: BoundFloat(0.25)
			),
			forOptionID: option1.id,
			staticAttributeId: oneAttribute.id
		)
		
		let option2 = Option(title: "b")
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "oneAttributeValue2",
				goodness: BoundFloat(0.75)
			),
			forOptionID: option2.id,
			staticAttributeId: oneAttribute.id
		)
		
		returnDecision.staticAttributes = [ oneAttribute ]
		returnDecision.options = [ option1, option2 ]
		returnDecision.title = "minimumSetup"
		
		return returnDecision
	}
	
	static var minimumOptions_greaterThan1Average: Decision {
		let returnDecision: Decision = Decision()
		
		let attribute1 = StaticAttribute(
			title: "attribute1",
			importance: BoundFloat(1.0)
		)
		let attribute2 = StaticAttribute(
			title: "attribute2",
			importance: BoundFloat(0.5)
		)
		
		let option1 = Option(title: "a")
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value1",
				goodness: BoundFloat(1.0)
			),
			forOptionID: option1.id,
			staticAttributeId: attribute1.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value1",
				goodness: BoundFloat(0.5)
			),
			forOptionID: option1.id,
			staticAttributeId: attribute2.id
		)
		
		let option2 = Option(title: "b")
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value2",
				goodness: BoundFloat(0.75)
			),
			forOptionID: option2.id,
			staticAttributeId: attribute1.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value2",
				goodness: BoundFloat(0.75)
			),
			forOptionID: option2.id,
			staticAttributeId: attribute2.id
		)
		
		returnDecision.staticAttributes = [
			attribute1,
			attribute2
		]
		returnDecision.options = [
			option1,
			option2
		]
		returnDecision.title = "minimumSetup"
		
		return returnDecision
	}
	
	static var minimumOptions_allZero: Decision {
		let returnDecision: Decision = Decision()
		
		let attribute1 = StaticAttribute(
			title: "attribute1",
			importance: BoundFloat(0.0)
		)
		let attribute2 = StaticAttribute(
			title: "attribute2",
			importance: BoundFloat(0.0)
		)
		
		let option1 = Option(title: "a")
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value1",
				goodness: BoundFloat(0.0)
			),
			forOptionID: option1.id,
			staticAttributeId: attribute1.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value1",
				goodness: BoundFloat(0.0)
			),
			forOptionID: option1.id,
			staticAttributeId: attribute2.id
		)
		
		let option2 = Option(title: "b")
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute1Value2",
				goodness: BoundFloat(0.0)
			),
			forOptionID: option2.id,
			staticAttributeId: attribute1.id
		)
		returnDecision.setOptionAttribute(
			OptionAttribute(
				value: "attribute2Value2",
				goodness: BoundFloat(0.0)
			),
			forOptionID: option2.id,
			staticAttributeId: attribute2.id
		)
		
		returnDecision.staticAttributes = [
			attribute1,
			attribute2
		]
		returnDecision.options = [
			option1,
			option2
		]
		returnDecision.title = "minimumSetup"
		
		return returnDecision
	}
}
