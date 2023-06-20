//
//  Views.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject var decision = Decision()
	@State private var activeNewAttribute: StaticAttribute? = nil
	@State private var activeNewOption: Option? = nil

	var body: some View {
		NavigationView {
			VStack {
				TextField("Decision Title", text: $decision.title)
					.font(.title)
					.padding(.bottom, 10)
					.textFieldStyle(.roundedBorder)
					.multilineTextAlignment(.center)
				
				List {
					Section(header: Text(Strings.StaticAttributes.groupLabel).textCase(.none)) {
						ForEach(decision.staticAttributes.indices, id: \.self) { index in
							NavigationLink(destination: EditStaticAttributeView(staticAttribute: $decision.staticAttributes[index]), tag: decision.staticAttributes[index], selection: $activeNewAttribute) {
								Text(decision.staticAttributes[index].title)
							}
						}
						Button(action: {
							let newStaticAttribute = StaticAttribute()
							decision.staticAttributes.append(newStaticAttribute)
							activeNewAttribute = newStaticAttribute
						}) {
							Label(Strings.StaticAttributes.addNewTitle, systemImage: "plus")
						}
					}
					
					Section(header: Text(Strings.Options.groupLabel).textCase(.none)) {
						ForEach(decision.options.indices, id: \.self) { index in
							NavigationLink(destination: EditOptionView(option: decision.options[index], decision: decision), tag: decision.options[index], selection: $activeNewOption) {
								Text(decision.options[index].title)
							}
						}
						Button(action: {
							let newOption = Option()
							decision.options.append(newOption)
							activeNewOption = newOption
						}) {
							Label(Strings.Options.addNewTitle, systemImage: "plus")
						}
					}
				}
			}
			.navigationBarTitle(Strings.App.title)
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
	@ObservedObject var option: Option
	@ObservedObject var decision: Decision

	var body: some View {
		Form {
			TextField(Strings.Options.defaultTitle, text: $option.title)
			ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
				if let optionAttribute = option.getOptionAttribute(for: staticAttribute) {
					NavigationLink(destination: EditOptionAttributeView(viewModel: OptionAttributeViewModel(staticAttribute: staticAttribute, option: option, optionAttribute: optionAttribute))) {
						Text(staticAttribute.title)
					}
				}
			}
		}
		.navigationTitle(Strings.Options.editOptionNavTitle)
	}
}
