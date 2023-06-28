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
			importance: Strings.ExampleData.BuyingAHouse.colorImportance
		)
		let priceAttribute = StaticAttribute(
			title: Strings.ExampleData.BuyingAHouse.price,
			importance: Strings.ExampleData.BuyingAHouse.priceImportance
		)
		let locationAttribute = StaticAttribute(
			title: Strings.ExampleData.BuyingAHouse.location,
			importance: Strings.ExampleData.BuyingAHouse.locationImportance
		)
		
		let option1 = Option(title: Strings.ExampleData.BuyingAHouse.Option1.title)
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
		
		let option2 = Option(title: Strings.ExampleData.BuyingAHouse.Option2.title)
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
		
		let option3 = Option(title: Strings.ExampleData.BuyingAHouse.Option3.title)
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
		
		let option4 = Option(title: Strings.ExampleData.BuyingAHouse.Option4.title)
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
}
