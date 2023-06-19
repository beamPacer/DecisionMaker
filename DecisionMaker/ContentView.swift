//
//  ContentView.swift
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
				Text("Decision Title")
					.font(.title)
					.padding(.bottom, 10)
				
				List {
					Section(header: Text("Static Attributes").textCase(.none)) {
						ForEach(decision.staticAttributes.indices, id: \.self) { index in
							NavigationLink(destination: EditStaticAttributeView(staticAttribute: $decision.staticAttributes[index])) {
								Text(decision.staticAttributes[index].title)
							}
						}
						Button(action: {
							let newStaticAttribute = StaticAttribute()
							newStaticAttribute.title = "New attribute"
							decision.staticAttributes.append(newStaticAttribute)
						}) {
							Label("Add New Attribute", systemImage: "plus")
						}
					}
					
					Section(header: Text("Options").textCase(.none)) {
						ForEach(decision.options.indices, id: \.self) { index in
							NavigationLink(destination: EditOptionView(option: decision.options[index], decision: decision)) {
								Text(decision.options[index].title)
							}
						}
						Button(action: {
							let newOption = Option(title: "New option")
							decision.options.append(newOption)
						}) {
							Label("Add New Option", systemImage: "plus")
						}
					}
				}
			}
			.navigationBarTitle("Decision Maker")
		}
	}
}

struct EditStaticAttributeView: View {
	@Binding var staticAttribute: StaticAttribute

	var body: some View {
		Form {
			TextField("Title", text: self.$staticAttribute.title)
			VStack(alignment: .leading) {
				Text("Importance:")
				Slider(value: $staticAttribute.importance.value, in: staticAttribute.importance.minimumLimit...staticAttribute.importance.maximumLimit)
			}
		}
		.navigationTitle("Edit Attribute")
	}
}

class OptionAttributeViewModel: ObservableObject {
	@Published var optionAttribute: OptionAttribute
	
	init(option: Option, staticAttribute: StaticAttribute) {
		self.optionAttribute = option.getOptionAttribute(for: staticAttribute)
	}
}

struct EditOptionAttributeView: View {
	@ObservedObject var viewModel: OptionAttributeViewModel

	var body: some View {
		TextField("Value", text: $viewModel.optionAttribute.value)
		VStack(alignment: .leading) {
			Text("Goodness:")
			Slider(value: $viewModel.optionAttribute.goodness.value, in: viewModel.optionAttribute.goodness.minimumLimit...viewModel.optionAttribute.goodness.maximumLimit)
		}
	}
}

struct EditOptionView: View {
	@ObservedObject var option: Option
	@ObservedObject var decision: Decision

	var body: some View {
		Form {
			TextField("Title", text: $option.title)
			ForEach(decision.staticAttributes, id: \.self) { staticAttribute in
				NavigationLink(destination: EditOptionAttributeView(viewModel: OptionAttributeViewModel(option: option, staticAttribute: staticAttribute))) {
					Text(staticAttribute.title)
				}
			}
		}
		.navigationTitle(option.title)
	}
}
