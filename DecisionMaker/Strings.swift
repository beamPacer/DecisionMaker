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
		static let groupLabel: String = "Static Attributes"
		static let addNewTitle: String = "Add New Attribute"
		static let newAttributeTitle: String = "New Attribute"
		static let defaultTitle: String = "Title"
		static let importanceLabel: String = "Importance:"
		static let editAttributeNavTitle: String = "Edit Attribute"
	}
	
	struct Options {
		static let groupLabel: String = "Options"
		static let addNewTitle: String = "Add New Option"
		static let newOptionTitle: String = "New Option"
		static let defaultTitle: String = "Title"
	}
	
	struct OptionAttributes {
		static let defaultValue: String = "Value"
		static let goodnessLabel: String = "Goodness:"
	}
}
