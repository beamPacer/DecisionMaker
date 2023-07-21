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
				
				Spacer()
					.frame(height: 30)
				
				HStack {
					Spacer()
					Button(action: {
						var newDecision = Decision()
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

struct NewDecisionView_Previews: PreviewProvider {
	@State static var isPresented: Bool = true
	@State static var newDecisionTitle: String = ""
	static let decisionData: DecisionData = DecisionData(ExampleData.buyingAHouse)
	
	static var previews: some View {
		NewDecisionView(isPresented: $isPresented, newDecisionTitle: $newDecisionTitle, decisionData: decisionData)
	}
}
