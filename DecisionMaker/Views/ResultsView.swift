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
		GeometryReader { geometry in
			ScrollView {
				VStack {
					Spacer()
						   .frame(height: 20)
					
					if let firstResult = results.first {
						Text(Strings.Result.bestOptionLabel)
						Text(firstResult.option.title)
							.font(.system(size: 32))
							.multilineTextAlignment(.center)
							.padding()
					}
					
					Spacer()
						   .frame(height: 20)
					
					Text(Strings.Result.scoresBreakdownLabel)
						.italic()
					
					Spacer()
						   .frame(height: 20)
					
					ResultSwiftUIView(results: results)
							.frame(width: geometry.size.width, height: 400)
				}
				.navigationTitle(Strings.Result.title)
			}
		}
	}
}
