//
//  Common.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct AnnotatedSlider: View {
	let startLabel: String
	let endLabel: String
	@Binding var value: Float
	var range: ClosedRange<Float>

	var body: some View {
		VStack(alignment: .leading) {
			Slider(value: $value, in: range)

			HStack(alignment: .center, spacing: 0) {
				Text(startLabel)
					.font(.caption)
					.foregroundColor(.gray)
				
				Spacer()

				Text(endLabel)
					.font(.caption)
					.foregroundColor(.gray)
			}
			.frame(maxWidth: .infinity)
			.padding(.horizontal, -1)
		}
	}
}

struct AnnotatedSlider_Previews: PreviewProvider {
	@State static var value: Float = 0.7
	
	static var previews: some View {
		Form {
			AnnotatedSlider(startLabel: "startLabel", endLabel: "endLabel", value: $value, range: 0...1)
		}
	}
}

struct SearchBar: View {
	@Binding var text: String
	
	var body: some View {
		HStack {
			TextField(Strings.Common.search, text: $text)
				.padding(.vertical, 8)
				.padding(.horizontal, 16)
				.background(Color(.systemGray5))
				.cornerRadius(8)
			
			Button(action: {
				text = ""
			}) {
				Image(systemName: "xmark.circle.fill")
					.foregroundColor(.gray)
					.font(.system(size: 20))
			}
			.padding(.trailing, 8)
			.opacity(text.isEmpty ? 0 : 1)
		}
	}
}

struct SearchBar_Previews: PreviewProvider {
	@State static var value: String = ""
	
	static var previews: some View {
		Form {
			SearchBar(text: $value)
		}
	}
}
