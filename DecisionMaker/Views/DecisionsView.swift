//
//  Views.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

struct DecisionListView: View {
	@EnvironmentObject var decisionData: DecisionData
	@State private var newDecisionTitle: String = ""
	@State private var isShowingNewDecisionView = false
	
	var body: some View {
		NavigationView {
			List {
				ForEach(decisionData.decisions.indices, id: \.self) { index in
					NavigationLink(destination: ContentView(decision: $decisionData.decisions[index])) {
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

struct ContentView: View {
	@Binding var decision: Decision
	@State private var isShowingNewAttributeView: Bool = false
	@State private var isShowingNewOptionView: Bool = false
	@State private var isShowingResultsView: Bool = false
	@State private var newAttribute: StaticAttribute = StaticAttribute()
	@State private var newOption: Option = Option()
	@State private var uiRefreshToggle: Bool = false

	var body: some View {
		GeometryReader { geometry in
			VStack {
				TextField(Strings.Decision.titlePlaceholder, text: $decision.title)
					.font(.title)
					.padding(.bottom, 10)
					.textFieldStyle(.roundedBorder)
					.multilineTextAlignment(.center)
				
				List {
					Section(header: Text(Strings.StaticAttributes.groupLabel).textCase(.none)) {
						ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
							NavigationLink(destination: EditStaticAttributeView(staticAttribute: .constant(staticAttribute))) {
								if uiRefreshToggle || !uiRefreshToggle {
									HStack {
										Text(staticAttribute.title)
										Spacer()
										Text(staticAttribute.emoji)
									}
									
								}
							}
							.onAppear {
								decision = Decision(
									staticAttributes: decision.staticAttributes,
									options: decision.options,
									title: decision.title
								)
							}
						}
						.onDelete { indexSet in
							decision.staticAttributes.remove(atOffsets: indexSet)
							refreshDecision()
						}

						Button(action: {
							let newStaticAttribute = StaticAttribute()
							decision.addAttribute(newStaticAttribute)
							newAttribute = newStaticAttribute
							isShowingNewAttributeView = true
						}) {
							Label(Strings.StaticAttributes.addNewTitle, systemImage: "plus")
						}
						.sheet(isPresented: $isShowingNewAttributeView) {
							NavigationView {
								EditStaticAttributeView(staticAttribute: $newAttribute)
									.navigationBarTitle(Strings.StaticAttributes.editAttributeNavTitle, displayMode: .inline)
									.toolbar {
										Button(Strings.Common.done) {
											isShowingNewAttributeView = false
										}
									}
							}
							.onDisappear {
								refreshDecision()
							}
						}
					}
					
					Section(header: Text(Strings.Options.groupLabel).textCase(.none)) {
						ForEach(decision.options, id: \.self) { option in
							NavigationLink(destination: EditOptionView(option: .constant(option), decision: decision)) {
								OptionCellView(option: option, decision: decision)
							}
						}
						.onDelete { indexSet in
							decision.options.remove(atOffsets: indexSet)
						}

						Button(action: {
							let newOptionStack = Option()
							decision.addOption(newOptionStack)
							newOption = newOptionStack
							isShowingNewOptionView = true
						}) {
							Label(Strings.Options.addNewTitle, systemImage: "plus")
						}
						.sheet(isPresented: $isShowingNewOptionView) {
							NavigationView {
								EditOptionView(option: .constant(newOption), decision: decision)
									.navigationBarTitle(Strings.Options.editOptionNavTitle, displayMode: .inline)
									.toolbar {
										Button(Strings.Common.done) {
											isShowingNewOptionView = false
										}
									}
							}
							.onDisappear {
								newOption = Option()
								refreshDecision()
							}
						}
					}
				}
				Button(action: {
					isShowingResultsView = true
				}) {
					Text(Strings.Decision.getResults)
						.font(.title2)
						.fontWeight(.bold)
						.padding()
						.frame(width: geometry.size.width / 2)
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(500)
				}
				.padding()
			}
			.sheet(isPresented: $isShowingResultsView) {
				NavigationView {
					ResultsView(results: decision.getResults())
						.toolbar {
							Button(Strings.Common.done) {
								isShowingResultsView = false
							}
						}
				}
			}
			.navigationBarTitle(Strings.App.title)
		}
	}
	
	func refreshDecision() {
		decision = Decision(
			staticAttributes: decision.staticAttributes,
			options: decision.options,
			title: decision.title
		)
	}
}

struct OptionCellView: View {
	let option: Option
	let decision: Decision
	
	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(option.title)
				.font(.headline)
				.bold()
				.lineLimit(1)
			
			ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
				let optionAttribute = option.getOptionAttribute(for: staticAttribute)
				
				HStack {
					Text("\(staticAttribute.emoji):")
						.fontWeight(.semibold)
						.foregroundColor(.secondary)
					
					Text(optionAttribute.value)
						.lineLimit(1)
						.truncationMode(.tail)
				}
			}
		}
		.padding(.vertical, 8)
	}
}
