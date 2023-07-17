//
//  StaticAttributesViews.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

class StaticAttributeViewModel: ObservableObject {
	@Published var staticAttribute: StaticAttribute
	
	init(staticAttribute: StaticAttribute) {
		self.staticAttribute = staticAttribute
	}
}

struct EditStaticAttributeView: View {
	@ObservedObject var viewModel: StaticAttributeViewModel
	@State private var selectedEmoji: String? = nil
	@State private var showEmojiPicker = false
	
	var body: some View {
		Form {
			HStack {
				TextField(Strings.StaticAttributes.defaultTitle, text: self.$viewModel.staticAttribute.title)
				Spacer()
				Button(action: {
					showEmojiPicker = true
				}) {
					Text(selectedEmoji == nil ? viewModel.staticAttribute.emoji : selectedEmoji!)
						.font(.largeTitle)
						.foregroundColor(.primary)
				}
				.sheet(isPresented: $showEmojiPicker, content: {
					EmojiPicker(emojis: [EmojiHandler.shared.allEmojisArray], selectedEmoji: $selectedEmoji)
						.onDisappear {
							if let selected = selectedEmoji {
								viewModel.staticAttribute.emoji = selected
							}
						}
				})
			}
			.listRowSeparator(.hidden)
			
			VStack(alignment: .leading) {
				Text(Strings.StaticAttributes.importanceLabel)
				AnnotatedSlider(
					startLabel: Strings.StaticAttributes.importanceSliderStartLabel,
					endLabel: Strings.StaticAttributes.importanceSliderEndLabel,
					value: $viewModel.staticAttribute.importance.value,
					range: viewModel.staticAttribute.importance.minimumLimit...viewModel.staticAttribute.importance.maximumLimit
				)
					.accentColor(.blue)
			}
		}
		.navigationTitle(Strings.StaticAttributes.editAttributeNavTitle)
	}
}

struct EditStaticAttributeView_Previews: PreviewProvider {
	@State static var value = ExampleData.buyingAHouse.staticAttributes.first!
	
	static var previews: some View {
		EditStaticAttributeView(viewModel: StaticAttributeViewModel(staticAttribute: value))
	}
}
