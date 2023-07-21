//
//  Views.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

struct DecisionView: View {
	@Binding var decision: Decision
	@State private var isShowingNewAttributeView: Bool = false
	@State private var isShowingNewOptionView: Bool = false
	@State private var isShowingResultsView: Bool = false
	@State private var newAttribute: StaticAttribute = StaticAttribute()
	@State private var newOption: Option = Option()

	var body: some View {
		GeometryReader { geometry in
			VStack {
				TextField(Strings.Decision.titlePlaceholder, text: $decision.title)
					.font(.title)
					.padding(.bottom, 10)
					.textFieldStyle(.roundedBorder)
					.multilineTextAlignment(.center)
				
				List {
					staticAttributesListView
					optionsListView
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
	
	var staticAttributesListView: some View {
		Section(header: Text(Strings.StaticAttributes.groupLabel).textCase(.none)) {
			ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
				NavigationLink(destination: EditStaticAttributeView(viewModel: StaticAttributeViewModel(staticAttribute: staticAttribute))) {
					HStack {
						Text(staticAttribute.title)
						Spacer()
						Text(staticAttribute.emoji)
					}
				}
			}
			.onDelete { indexSet in
				decision.staticAttributes.remove(atOffsets: indexSet)
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
					EditStaticAttributeView(viewModel: StaticAttributeViewModel(staticAttribute: newAttribute))
						.navigationBarTitle(Strings.StaticAttributes.editAttributeNavTitle, displayMode: .inline)
						.toolbar {
							Button(Strings.Common.done) {
								isShowingNewAttributeView = false
							}
						}
				}
			}
		}
	}
	
	var optionsListView: some View {
		Section(header: Text(Strings.Options.groupLabel).textCase(.none)) {
			ForEach(decision.options, id: \.self) { option in
				NavigationLink(destination: EditOptionView(option: .constant(option), decision: $decision)) {
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
					EditOptionView(option: .constant(newOption), decision: $decision)
						.navigationBarTitle(Strings.Options.editOptionNavTitle, displayMode: .inline)
						.toolbar {
							Button(Strings.Common.done) {
								isShowingNewOptionView = false
							}
						}
				}
				.onDisappear {
					newOption = Option()
				}
			}
		}
	}
}

struct DecisionView_Previews: PreviewProvider {
	@State static var value: Decision = ExampleData.buyingAHouse
	
	static var previews: some View {
		DecisionView(decision: $value)
	}
}

struct OptionCellView: View {
	let option: Option
	var decision: Decision
	
	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(option.title)
				.font(.title3)
				.bold()
				.lineLimit(1)
			
			ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
				let optionAttribute = option.getOptionAttribute(for: staticAttribute)
				
				HStack {
					Text("\(staticAttribute.emoji)")
						.frame(width: 30, alignment: .leading)
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

struct OptionCellView_Previews: PreviewProvider {
	static let value: Decision = ExampleData.buyingAHouse
	
	static var previews: some View {
		OptionCellView(
			option: value.options.last!,
			decision: value
		)
	}
}
