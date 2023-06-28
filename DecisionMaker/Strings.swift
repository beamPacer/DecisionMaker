//
//  Strings.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/19/23.
//

import Foundation

struct Strings {
	struct App {
		static let title: String = "Decision Maker"
	}
	
	struct ExampleData {
		struct BuyingAHouse {
			static let title: String = "Example: House Buying"
			
			static let color: String = "Color"
			static let colorImportance: BoundFloat = BoundFloat(0.27)
			static let price: String = "Price"
			static let priceImportance: BoundFloat = BoundFloat(1.0)
			static let location: String = "Location"
			static let locationImportance: BoundFloat = BoundFloat(0.6)
			
			struct Option1 {
				static let title: String = "144 38th St."
				static let color: String = "Green"
				static let colorGoodness: BoundFloat = BoundFloat(0.4)
				static let price: String = "244k"
				static let priceGoodness: BoundFloat = BoundFloat(0.13)
				static let location: String = "Near work"
				static let locationGoodness: BoundFloat = BoundFloat(0.9)
			}
			
			struct Option2 {
				static let title: String = "N. Broadway Yellow House"
				static let color: String = "Yellow"
				static let colorGoodness: BoundFloat = BoundFloat(0.1)
				static let price: String = "197k"
				static let priceGoodness: BoundFloat = BoundFloat(0.3)
				static let location: String = "Near dog park"
				static let locationGoodness: BoundFloat = BoundFloat(1.0)
			}
			
			struct Option3 {
				static let title: String = "Condo on 47th"
				static let color: String = "Brown"
				static let colorGoodness: BoundFloat = BoundFloat(0.35)
				static let price: String = "152k"
				static let priceGoodness: BoundFloat = BoundFloat(0.66)
				static let location: String = "Nearest to work"
				static let locationGoodness: BoundFloat = BoundFloat(0.95)
			}
			
			struct Option4 {
				static let title: String = "Split-level on Grand"
				static let color: String = "Purple"
				static let colorGoodness: BoundFloat = BoundFloat(1.0)
				static let price: String = "114k"
				static let priceGoodness: BoundFloat = BoundFloat(1.0)
				static let location: String = "Near Gym"
				static let locationGoodness: BoundFloat = BoundFloat(0.8)
			}
		}
	}
	
	struct Decision {
		static let newDecisionTitle: String = "New Decision"
		static let enterNewPrompt: String = "Enter decision title"
		static let titlePlaceholder: String = "Decision Title"
		static let getResults: String = "Get Results"
		static let addNewTitle: String = "Add new decision"
		static let mainListTitle: String = "Decisions"
	}
	
	struct Result {
		static let title: String = "Results"
		static let oneItemTitle: String = "You only have one option in your list! Come back when you have more options to consider."
		static let noItemsTitle: String = "You don't have any options in your list! Come back when you've added some."
	}
	
	struct StaticAttributes {
		static let groupLabel: String = "Attributes I'm looking for"
		static let addNewTitle: String = "Add new attribute"
		static let newAttributeTitle: String = "New attribute"
		static let defaultTitle: String = "Title"
		static let importanceLabel: String = "Importance:"
		static let editAttributeNavTitle: String = "Edit attribute"
	}
	
	struct Options {
		static let groupLabel: String = "Options I have"
		static let addNewTitle: String = "Add new option"
		static let newOptionTitle: String = "New option"
		static let defaultTitle: String = "Title"
		static let editOptionNavTitle: String = "Edit option"
	}
	
	struct OptionAttributes {
		static let defaultValue: String = "Value"
		static let goodnessLabel: String = "How happy I am with this value:"
	}
	
	struct Common {
		static let done: String = "Done"
	}
}
