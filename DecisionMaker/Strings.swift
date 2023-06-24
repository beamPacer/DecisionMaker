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
	
	struct Decision {
		static let newDecisionTitle: String = "New Decision"
		static let getResults: String = "Get Results"
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
