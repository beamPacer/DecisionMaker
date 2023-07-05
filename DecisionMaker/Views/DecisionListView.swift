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
					NewDecisionView(isPresented: $isShowingNewDecisionView, newDecisionTitle: $newDecisionTitle, decisionData: decisionData)
				}
			}
			.navigationBarTitle(Strings.Decision.mainListTitle)
		}
	}
}

struct DecisionListView_Previews: PreviewProvider {
	static let value: DecisionData = DecisionData(ExampleData.buyingAHouse)
	
	static var previews: some View {
		DecisionListView().environmentObject(value)
	}
}
