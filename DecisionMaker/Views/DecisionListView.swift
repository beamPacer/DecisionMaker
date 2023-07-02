//
//  DecisionListView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct DecisionListView: View {
	@EnvironmentObject var decisionData: DecisionData
	@State private var newDecisionTitle: String = ""
	@State private var isShowingNewDecisionView = false
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(decisionData.decisions.indices, id: \.self) { index in
					NavigationLink(destination: DecisionView(decision: $decisionData.decisions[index])) {
						Text(decisionData.decisions[index].title)
					}
				}
				.onDelete { indexSet in
					decisionData.decisions.remove(atOffsets: indexSet)
				}
				
				Button(action: {
					isShowingNewDecisionView = true
				}) {
					Label(Strings.Decision.addNewTitle, systemImage: "plus")
				}
				.sheet(isPresented: $isShowingNewDecisionView) {
					NavigationView {
						VStack {
							TextField(Strings.Decision.enterNewPrompt, text: $newDecisionTitle)
								.textFieldStyle(.roundedBorder)
								.padding()
							
							Button(action: {
								let newDecision = Decision()
								newDecision.title = newDecisionTitle
								decisionData.decisions.append(newDecision)
								isShowingNewDecisionView = false
								newDecisionTitle = ""
							}) {
								Text(Strings.Common.done)
									.font(.title2)
									.fontWeight(.bold)
									.padding()
									.background(Color.blue)
									.foregroundColor(.white)
									.cornerRadius(10)
									.padding()
							}
						}
					}
				}
			}
			.navigationBarTitle(Strings.Decision.mainListTitle)
		}
	}
}
