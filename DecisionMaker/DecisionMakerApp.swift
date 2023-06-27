//
//  DecisionMakerApp.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

@main
struct DecisionMakerApp: App {
	@StateObject var decisionData = DecisionData()
	
	var body: some Scene {
		WindowGroup {
			DecisionListView()
				.environmentObject(decisionData)
		}
	}
}
