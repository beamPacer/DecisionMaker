//
//  Persistence.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/27/23.
//

import Foundation

struct Persistence {
	static let shared = Persistence()
	
	private static let currentPersistenceVersion = 2
	private static let currentPersistenceKey = "persistence_version"
	
	func getLatestPersistenceVersion() -> Int {
		if UserDefaults.standard.object(forKey: Persistence.currentPersistenceKey) != nil {
			return UserDefaults.standard.integer(forKey: Persistence.currentPersistenceKey)
		}
		
		return 0
	}
	
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
			if returnValue.decisions.isEmpty {
				return DecisionData(ExampleData.buyingAHouse)
			}
			
			return returnValue
		}
		
		return DecisionData(ExampleData.buyingAHouse)
	}
	
	func forceLoadLatestExample(into data: DecisionData) -> DecisionData {
		var filteredDecisions = data.decisions.filter { $0.title != Strings.ExampleData.BuyingAHouse.title }
		filteredDecisions.append(ExampleData.buyingAHouse)
		return DecisionData(filteredDecisions)
	}
}
