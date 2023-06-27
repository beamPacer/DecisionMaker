//
//  Views.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var decision = Decision()
	@State private var isShowingNewAttributeView: Bool = false
	@State private var isShowingNewOptionView: Bool = false
	@State private var isShowingResultsView: Bool = false
	@State private var newAttribute: StaticAttribute = StaticAttribute()
	@State private var newOption: Option = Option()

	var body: some View {
		GeometryReader { geometry in
			NavigationView {
				VStack {
					TextField("Decision Title", text: $decision.title)
						.font(.title)
						.padding(.bottom, 10)
						.textFieldStyle(.roundedBorder)
						.multilineTextAlignment(.center)
					
					List {
						Section(header: Text(Strings.StaticAttributes.groupLabel).textCase(.none)) {
							ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
								NavigationLink(destination: EditStaticAttributeView(staticAttribute: .constant(staticAttribute))) {
									Text(staticAttribute.title)
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
									EditStaticAttributeView(staticAttribute: $newAttribute)
										.navigationBarTitle(Strings.StaticAttributes.editAttributeNavTitle, displayMode: .inline)
										.toolbar {
											Button(Strings.Common.done) {
												isShowingNewAttributeView = false
											}
										}
								}
								.onDisappear {
									newAttribute = StaticAttribute()
									if let lastStaticAttribute = decision.staticAttributes.last {
										lastStaticAttribute.objectWillChange.send()
									}
									decision.objectWillChange.send()
								}
							}
						}
						
						Section(header: Text(Strings.Options.groupLabel).textCase(.none)) {
							ForEach(decision.options, id: \.self) { option in
								NavigationLink(destination: EditOptionView(option: .constant(option), decision: decision)) {
									Text(option.title)
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
									if let lastOption = decision.options.last {
										lastOption.objectWillChange.send()
									}
									decision.objectWillChange.send()
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
							.padding()
					}
					.padding()
				}
				.sheet(isPresented: $isShowingResultsView) {
					NavigationView {
						ResultsView(options: decision.getResults())
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
	}
}

struct ResultsView: View {
	var options: [Option]
	
	var body: some View {
		GeometryReader { geometry in
			switch options.count {
			case 0:
				VStack {
					Spacer()
					HStack {
						Spacer()
						Text(Strings.Result.noItemsTitle)
							.frame(width: geometry.size.width * 0.75)
							.font(.system(size: 22))
							.multilineTextAlignment(.center)
						Spacer()
					}
					Spacer()
				}
			case 1:
				VStack {
					Spacer()
					HStack {
						Spacer()
						Text(Strings.Result.oneItemTitle)
							.frame(width: geometry.size.width * 0.75)
							.font(.system(size: 22))
							.multilineTextAlignment(.center)
						Spacer()
					}
					Spacer()
				}
			default:
				List(options, id: \.self) { option in
					Text(option.title)
				}
				.navigationTitle(Strings.Result.title)
			}
		}
	}
}

struct EditStaticAttributeView: View {
	@Binding var staticAttribute: StaticAttribute

	var body: some View {
		Form {
			TextField(Strings.StaticAttributes.defaultTitle, text: self.$staticAttribute.title)
			VStack(alignment: .leading) {
				Text(Strings.StaticAttributes.importanceLabel)
				Slider(value: $staticAttribute.importance.value, in: staticAttribute.importance.minimumLimit...staticAttribute.importance.maximumLimit)
			}
		}
		.navigationTitle(Strings.StaticAttributes.editAttributeNavTitle)
	}
}

class OptionAttributeViewModel: ObservableObject {
	let staticAttribute: StaticAttribute
	let option: Option
	@Published var optionAttribute: OptionAttribute
	
	init(staticAttribute: StaticAttribute, option: Option, optionAttribute: OptionAttribute) {
		self.staticAttribute = staticAttribute
		self.option = option
		self.optionAttribute = optionAttribute
	}
}

struct EditOptionAttributeView: View {
	@ObservedObject var viewModel: OptionAttributeViewModel

	var body: some View {
		Form {
			TextField(Strings.OptionAttributes.defaultValue, text: $viewModel.optionAttribute.value)
			VStack(alignment: .leading) {
				Text(Strings.OptionAttributes.goodnessLabel)
				Slider(value: $viewModel.optionAttribute.goodness.value,
					   in: viewModel.optionAttribute.goodness.minimumLimit...viewModel.optionAttribute.goodness.maximumLimit)
			}
		}
		.navigationTitle(viewModel.staticAttribute.title)
	}
}

struct EditOptionView: View {
	@Binding var option: Option
	@ObservedObject var decision: Decision

	var body: some View {
		Form {
			TextField(Strings.Options.defaultTitle, text: $option.title)
			ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
					NavigationLink(destination: EditOptionAttributeView(
						viewModel: OptionAttributeViewModel(
							staticAttribute: staticAttribute,
							option: option,
							optionAttribute: option.getOptionAttribute(for: staticAttribute)
						)
					)) {
						Text(staticAttribute.title)
					}
			}
		}
		.navigationTitle(Strings.Options.editOptionNavTitle)
	}
}
