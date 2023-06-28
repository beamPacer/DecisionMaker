//
//  Persistence.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/27/23.
//

import Foundation

struct Persistence {
	static let shared = Persistence()
	
	func getArchiveURL() -> URL {
		let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		return documentsDirectory.appendingPathComponent("decision_data").appendingPathExtension("plist")
	}

	func saveDecisionData(_ decisionData: DecisionData) {
		let encoder = PropertyListEncoder()
		if let encodedDecisionData = try? encoder.encode(decisionData) {
			try? encodedDecisionData.write(to: getArchiveURL(), options: .noFileProtection)
		}
	}

	func loadDecisionData() -> DecisionData {
		guard let codeData = try? Data(contentsOf: getArchiveURL()) else {
			// Brand new install; load up the example payload
			return DecisionData(ExampleData.buyingAHouse)
		}
		let decoder = PropertyListDecoder()
		if let returnValue = try? decoder.decode(DecisionData.self, from: codeData) {
			return returnValue
		}
		
		return DecisionData()
	}
}
