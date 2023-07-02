//
//  Strings.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/19/23.
//

import Foundation

struct Strings {
	struct App {
		static let title: String = String(localized: "app.title")
	}
	
	struct ExampleData {
		struct BuyingAHouse {
			static let title: String = String(localized: "exampleData.buyingAHouse.title")
			
			static let color: String = String(localized: "exampleData.buyingAHouse.color")
			static let colorImportance: BoundFloat = BoundFloat(0.27)
			static let price: String = String(localized: "exampleData.buyingAHouse.price")
			static let priceImportance: BoundFloat = BoundFloat(1.0)
			static let location: String = String(localized: "exampleData.buyingAHouse.location")
			static let locationImportance: BoundFloat = BoundFloat(0.6)
			
			struct Option1 {
				static let title: String = String(localized: "exampleData.buyingAHouse.option1.title")
				static let color: String = String(localized: "exampleData.buyingAHouse.option1.color")
				static let colorGoodness: BoundFloat = BoundFloat(0.4)
				static let price: String = String(localized: "exampleData.buyingAHouse.option1.price")
				static let priceGoodness: BoundFloat = BoundFloat(0.13)
				static let location: String = String(localized: "exampleData.buyingAHouse.option1.location")
				static let locationGoodness: BoundFloat = BoundFloat(0.9)
			}
			
			struct Option2 {
				static let title: String = String(localized: "exampleData.buyingAHouse.option2.title")
				static let color: String = String(localized: "exampleData.buyingAHouse.option2.color")
				static let colorGoodness: BoundFloat = BoundFloat(0.1)
				static let price: String = String(localized: "exampleData.buyingAHouse.option2.price")
				static let priceGoodness: BoundFloat = BoundFloat(0.3)
				static let location: String = String(localized: "exampleData.buyingAHouse.option2.location")
				static let locationGoodness: BoundFloat = BoundFloat(1.0)
			}
			
			struct Option3 {
				static let title: String = String(localized: "exampleData.buyingAHouse.option3.title")
				static let color: String = String(localized: "exampleData.buyingAHouse.option3.color")
				static let colorGoodness: BoundFloat = BoundFloat(0.35)
				static let price: String = String(localized: "exampleData.buyingAHouse.option3.price")
				static let priceGoodness: BoundFloat = BoundFloat(0.66)
				static let location: String = String(localized: "exampleData.buyingAHouse.option3.location")
				static let locationGoodness: BoundFloat = BoundFloat(0.95)
			}
			
			struct Option4 {
				static let title: String = String(localized: "exampleData.buyingAHouse.option4.title")
				static let color: String = String(localized: "exampleData.buyingAHouse.option4.color")
				static let colorGoodness: BoundFloat = BoundFloat(1.0)
				static let price: String = String(localized: "exampleData.buyingAHouse.option4.price")
				static let priceGoodness: BoundFloat = BoundFloat(1.0)
				static let location: String = String(localized: "exampleData.buyingAHouse.option4.location")
				static let locationGoodness: BoundFloat = BoundFloat(0.8)
			}
		}
	}
	
	struct Decision {
		static let newDecisionTitle: String = String(localized: "decision.newDecisionTitle")
		static let newDecisionPrompt: String = String(localized: "decision.newDecisionPrompt")
		static let enterNewPrompt: String = String(localized: "decision.enterNewPrompt")
		static let titlePlaceholder: String = String(localized: "decision.titlePlaceholder")
		static let getResults: String = String(localized: "decision.getResults")
		static let addNewTitle: String = String(localized: "decision.addNewTitle")
		static let mainListTitle: String = String(localized: "decision.mainListTitle")
	}
	
	struct Result {
		static let title: String = String(localized: "result.title")
		static let oneItemTitle: String = String(localized: "result.oneItemTitle")
		static let noItemsTitle: String = String(localized: "result.noItemsTitle")
		static let runnersUpTitle: String = String(localized: "result.runnersUpTitle")
	}
	
	struct StaticAttributes {
		static let groupLabel: String = String(localized: "staticAttributes.groupLabel")
		static let addNewTitle: String = String(localized: "staticAttributes.addNewTitle")
		static let newAttributeTitle: String = String(localized: "staticAttributes.newAttributeTitle")
		static let defaultTitle: String = String(localized: "staticAttributes.defaultTitle")
		static let importanceLabel: String = String(localized: "staticAttributes.importanceLabel")
		static let editAttributeNavTitle: String = String(localized: "staticAttributes.editAttributeNavTitle")
		static let importanceSliderStartLabel: String = String(localized: "staticAttributes.importanceSliderStartLabel")
		static let importanceSliderEndLabel: String = String(localized: "staticAttributes.importanceSliderEndLabel")
	}
	
	struct Options {
		static let groupLabel: String = String(localized: "options.groupLabel")
		static let addNewTitle: String = String(localized: "options.addNewTitle")
		static let newOptionTitle: String = String(localized: "options.newOptionTitle")
		static let defaultTitle: String = String(localized: "options.defaultTitle")
		static let editOptionNavTitle: String = String(localized: "options.editOptionNavTitle")
	}
	
	struct OptionAttributes {
		static let defaultValue: String = String(localized: "optionAttributes.defaultValue")
		static let goodnessLabel: String = String(localized: "optionAttributes.goodnessLabel")
		static let goodnessSliderStartLabel: String = String(localized: "optionAttributes.goodnessSliderStartLabel")
		static let goodnessSliderEndLabel: String = String(localized: "optionAttributes.goodnessSliderEndLabel")
	}
	
	struct Common {
		static let done: String = String(localized: "common.done")
		static let search: String = String(localized: "common.search")
		static let defaultEmoji: String = String(localized: "common.defaultEmoji")
	}
	
	struct EmojiPicker {
		static let title: String = String(localized: "emojiPicker.title")
	}
}
