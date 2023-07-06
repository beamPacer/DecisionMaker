//
//  DecisionData.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 7/6/23.
//

import Foundation

/*
 This code models making a decision using weighted average. Decisions have
 static attributes and they have options. Attributes of those options are stored
 by each option; each option holds a map that maps static attributes to option
 attributes. For this static attribute, here's the option attribute. The
 initialization of the option attributes map in each option is lazy.
 
 [ Decision ]------> [ StaticAttribute ]
   |                        |
   V                        V
 [ Option ] <----> [ OptionAttribute ]
 */

class DecisionData: ObservableObject, Codable {
	@Published var decisions: [Decision] = []
	
	init() { decisions = [] }
	init(_ decision: Decision) { self.decisions = [decision] }
	init(_ decisions: [Decision]) { self.decisions = decisions }
	
	// MARK: Codable conformance
	
	enum CodingKeys: CodingKey {
		case decisions
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		decisions = try container.decode([Decision].self, forKey: .decisions)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(decisions, forKey: .decisions)
	}
}
