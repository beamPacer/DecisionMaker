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
