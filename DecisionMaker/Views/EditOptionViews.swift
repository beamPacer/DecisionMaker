//
//  OptionsViews.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct EditOptionAttributeView: View {
	let staticAttribute: StaticAttribute
	let option: Option
	@State var optionAttribute: OptionAttribute

	var body: some View {
		TextField(Strings.OptionAttributes.defaultValue, text: $optionAttribute.value)
		VStack(alignment: .leading) {
			Text(Strings.OptionAttributes.goodnessLabel)
				.italic()
			AnnotatedSlider(
				startLabel: Strings.OptionAttributes.goodnessSliderStartLabel,
				endLabel: Strings.OptionAttributes.goodnessSliderEndLabel,
				value: $optionAttribute.goodness.value,
				range: optionAttribute.goodness.minimumLimit...optionAttribute.goodness.maximumLimit
			)
				.accentColor(.blue)
		}
	}
}

struct EditOptionAttributeView_Previews: PreviewProvider {
	static let exampleData = ExampleData.buyingAHouse
	
	static var previews: some View {
		EditOptionAttributeView(
			staticAttribute: exampleData.staticAttributes.first!,
			option: exampleData.options.last!,
			optionAttribute: exampleData.options.last!.getOptionAttribute(for: exampleData.staticAttributes.first!)
		)
	}
}

struct EditOptionView: View {
	@Binding var option: Option
	@Binding var decision: Decision
	@State private var uiRefreshToggle: Bool = false

	var body: some View {
		Form {
			Section() {
				TextField(Strings.Options.defaultTitle, text: $option.title)
			}
			
			Section() {
				ForEach(Array(decision.staticAttributes.enumerated()), id: \.offset) { index, staticAttribute in
					VStack {
						HStack {
							Text(staticAttribute.title)
								.bold()
							Spacer()
							Text(staticAttribute.emoji)
						}
						
						EditOptionAttributeView(
							staticAttribute: staticAttribute,
							option: option,
							optionAttribute: option.getOptionAttribute(for: staticAttribute)
						)
					}
				}
			}
		}
		.navigationTitle(Strings.Options.editOptionNavTitle)
	}
}

struct EditOptionView_Previews: PreviewProvider {
	@State static var option = ExampleData.buyingAHouse.options.last!
	static let decision = ExampleData.buyingAHouse
	
	static var previews: some View {
		EditOptionView(option: $option, decision: .constant(decision))
	}
}
