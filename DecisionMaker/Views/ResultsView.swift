//
//  ResultsView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct ResultsView: View {
	var results: [Result]
	
	var body: some View {
		GeometryReader { geometry in
			switch results.count {
			case 0:		emptyStateView(hasOneOption: false)
			case 1:		emptyStateView(hasOneOption: true)
			default:	properResultsView
			}
		}
	}
	
	func emptyStateView(hasOneOption: Bool) -> some View {
		let title = hasOneOption ? Strings.Result.oneItemTitle : Strings.Result.noItemsTitle
		
		return GeometryReader { geometry in
			VStack {
				Spacer()
				HStack {
					Spacer()
					Text(title)
						.frame(width: geometry.size.width * 0.75)
						.font(.system(size: 22))
						.multilineTextAlignment(.center)
					Spacer()
				}
				Spacer()
			}
		}
	}
	
	var properResultsView: some View {
		VStack {
			if let firstResult = results.first {
				Text(firstResult.option.title)
					.font(.system(size: 32))
					.multilineTextAlignment(.center)
					.padding()
				Text(formatPercentWeightedAverage(for: firstResult))
			}
			
			List {
				Section(header: Text(Strings.Result.runnersUpTitle)) {
					ForEach(results.dropFirst(), id: \.self) { result in
						HStack {
							Text(result.option.title)
							Spacer()
							Text(formatPercentWeightedAverage(for: result))
								.foregroundColor(.gray)
						}
					}
				}
			}
		}
		.navigationTitle(Strings.Result.title)
	}
	
	private func formatPercentWeightedAverage(for result: Result) -> String {
		"\(Int(result.percentWeightedAverage * 100))%"
	}
}
