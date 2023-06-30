//
//  EmojiPickerView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct EmojiPicker: View {
	@Binding var selectedEmoji: String
	
	var body: some View {
		VStack {
			Text("Choose an Emoji")
				.font(.title)
				.padding()
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 20) {
					ForEach(EmojiHandler.shared.allEmojisArray, id: \.self) { emoji in
						Button(action: {
							selectedEmoji = emoji
						}) {
							Text(emoji)
								.font(.system(size: 50))
								.padding()
								.background(
									RoundedRectangle(cornerRadius: 10)
										.fill(selectedEmoji == emoji ? Color.blue : Color.gray)
								)
								.foregroundColor(.white)
						}
					}
				}
				.padding()
			}
		}
	}
}
