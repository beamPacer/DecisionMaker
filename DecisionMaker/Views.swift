//
//  Views.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/17/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject var decision = Decision()

	var body: some View {
		NavigationView {
			VStack {
				Text(decision.title)
					.font(.title)
					.padding(.bottom, 10)
				
				List {
					Section(header: Text(Strings.StaticAttributes.groupLabel).textCase(.none)) {
						ForEach(decision.staticAttributes.indices, id: \.self) { index in
							NavigationLink(destination: EditStaticAttributeView(staticAttribute: $decision.staticAttributes[index])) {
								Text(decision.staticAttributes[index].title)
							}
						}
						Button(action: {
							let newStaticAttribute = StaticAttribute()
							newStaticAttribute.title = Strings.StaticAttributes.newAttributeTitle
							decision.staticAttributes.append(newStaticAttribute)
						}) {
							Label( Strings.StaticAttributes.addNewTitle, systemImage: "plus")
						}
					}
					
					Section(header: Text(Strings.Options.groupLabel).textCase(.none)) {
						ForEach(decision.options.indices, id: \.self) { index in
							NavigationLink(destination: EditOptionView(option: decision.options[index], decision: decision)) {
								Text(decision.options[index].title)
							}
						}
						Button(action: {
							let newOption = Option(title: Strings.Options.newOptionTitle)
							decision.options.append(newOption)
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
	@Published var optionAttribute: OptionAttribute
	
	init(optionAttribute: OptionAttribute) {
		self.optionAttribute = optionAttribute
	}
}

struct EditOptionAttributeView: View {
	@ObservedObject var viewModel: OptionAttributeViewModel

	var body: some View {
		TextField(Strings.OptionAttributes.defaultValue, text: $viewModel.optionAttribute.value)
		VStack(alignment: .leading) {
			Text(Strings.OptionAttributes.goodnessLabel)
			Slider(value: $viewModel.optionAttribute.goodness.value,
				   in: viewModel.optionAttribute.goodness.minimumLimit...viewModel.optionAttribute.goodness.maximumLimit)
		}
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
					NavigationLink(destination: EditOptionAttributeView(viewModel: OptionAttributeViewModel(optionAttribute: optionAttribute))) {
						Text(staticAttribute.title)
					}
				}
			}
		}
		.navigationTitle(option.title)
	}
}
