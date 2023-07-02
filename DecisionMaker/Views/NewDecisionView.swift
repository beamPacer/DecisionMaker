//
//  NewDecisionView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 7/2/23.
//

import SwiftUI

struct NewDecisionView: View {
	@Binding var isPresented: Bool
	@Binding var newDecisionTitle: String
	@ObservedObject var decisionData: DecisionData

	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				Text(Strings.Decision.newDecisionPrompt)
					.font(.headline)
					.foregroundColor(.gray)
					.padding([.leading, .top])

				TextField(Strings.Decision.enterNewPrompt, text: $newDecisionTitle)
					.textFieldStyle(.roundedBorder)
					.padding(.horizontal)
				
				HStack {
					Spacer()
					Button(action: {
						let newDecision = Decision()
						newDecision.title = newDecisionTitle
						decisionData.decisions.append(newDecision)
						isPresented = false
						newDecisionTitle = ""
					}) {
						Text(Strings.Common.done)
							.font(.title2)
							.fontWeight(.bold)
							.padding()
							.background(Color.blue)
							.foregroundColor(.white)
							.cornerRadius(10)
					}
					Spacer()
				}
				.padding(.horizontal)

				Spacer()
			}
			.padding()
			.navigationBarTitle(Strings.Decision.newDecisionTitle, displayMode: .inline)
		}
	}
}
