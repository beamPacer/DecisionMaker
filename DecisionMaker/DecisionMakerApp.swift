//
//  DecisionMakerApp.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

@main
struct DecisionMakerApp: App {
	@StateObject var decisionData = Persistence.shared.loadDecisionData()

	var body: some Scene {
		WindowGroup {
			DecisionListView()
				.environmentObject(decisionData)
				.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
					Persistence.shared.saveDecisionData(decisionData)
				}
		}
	}
}
