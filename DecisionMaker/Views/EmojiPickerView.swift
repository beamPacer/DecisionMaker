//
//  EmojiPickerView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct EmojiPicker: View {
	let emojis: [[String]]
	@Binding var selectedEmoji: String?
	@State var searchText = ""
	@Environment(\.presentationMode) var presentationMode
	
	var filteredEmojis: [[String]] {
		if searchText.isEmpty || searchText.count == 1 {
			return emojis
		} else {
			return [EmojiHandler.shared.emojis(for: searchText)]
		}
	}
	
	let gridItemLayout = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible())
	]
		
	var body: some View {
		NavigationView {
			VStack {
				SearchBar(text: $searchText)
					.padding(.horizontal)
				
				ScrollView {
					LazyVGrid(columns: gridItemLayout, spacing: 8) {
						ForEach(filteredEmojis.indices, id: \.self) { row in
							ForEach(filteredEmojis[row].indices, id: \.self) { column in
								let emoji = filteredEmojis[row][column]
								
								Button(action: {
									selectedEmoji = emoji
									presentationMode.wrappedValue.dismiss()
								}) {
									Text(emoji)
										.font(.title)
								}
							}
						}
					}
					.padding()
				}
			}
			.navigationBarItems(trailing: doneButton)
		}
	}
	
	var doneButton: some View {
		Button(action: {
			presentationMode.wrappedValue.dismiss()
		}) {
			Text(Strings.Common.done)
				.font(.headline)
				.foregroundColor(.blue)
		}
	}
}
