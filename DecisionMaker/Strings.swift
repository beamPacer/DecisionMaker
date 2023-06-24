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
