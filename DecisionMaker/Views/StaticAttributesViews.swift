//
//  StaticAttributesViews.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct EditStaticAttributeView: View {
	@Binding var staticAttribute: StaticAttribute
	@State private var selectedEmoji: String? = nil
	@State private var showEmojiPicker = false
	
	var body: some View {
		Form {
			HStack {
				TextField(Strings.StaticAttributes.defaultTitle, text: self.$staticAttribute.title)
				Spacer()
				Button(action: {
					showEmojiPicker = true
				}) {
					Text(selectedEmoji == nil ? staticAttribute.emoji : selectedEmoji!)
						.font(.largeTitle)
				}
				.sheet(isPresented: $showEmojiPicker, content: {
					EmojiPicker(emojis: [EmojiHandler.shared.allEmojisArray], selectedEmoji: $selectedEmoji)
						.onDisappear {
							if let selected = selectedEmoji {
								staticAttribute.emoji = selected
							}
							
							staticAttribute.objectWillChange.send()
						}
				})
			}
			
			VStack(alignment: .leading) {
				Text(Strings.StaticAttributes.importanceLabel)
				Slider(value: $staticAttribute.importance.value, in: staticAttribute.importance.minimumLimit...staticAttribute.importance.maximumLimit)
			}
		}
		.navigationTitle(Strings.StaticAttributes.editAttributeNavTitle)
	}
}
