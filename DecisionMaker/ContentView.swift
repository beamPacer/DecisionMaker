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
							NavigationLink(destination: EditOptionView(option: $decision.options[index])) {
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
				Text("Importance: \(staticAttribute.importance.value, specifier: "%.2f")")
				Slider(value: $staticAttribute.importance.value, in: staticAttribute.importance.minimumLimit...staticAttribute.importance.maximumLimit)
			}
		}
		.navigationTitle("Edit Attribute")
	}
}

struct EditOptionView: View {
	@Binding var option: Option

	var body: some View {
		Form {
			// show a little grey label that says "Title"
			TextField("Title", text: self.$option.title)
			// show all values for all static attributes.
			// each is clickable and brings you to a view titled the
			// title of the static attribute, and showing the value in an
			// editable field, and with a "goodness" slider like the setup in
			// EditStaticAttributeView.
		}
		.navigationTitle($option.title)
	}
}
