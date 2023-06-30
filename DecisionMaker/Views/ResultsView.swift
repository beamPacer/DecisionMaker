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
			case 0:
				VStack {
					Spacer()
					HStack {
						Spacer()
						Text(Strings.Result.noItemsTitle)
							.frame(width: geometry.size.width * 0.75)
							.font(.system(size: 22))
							.multilineTextAlignment(.center)
						Spacer()
					}
					Spacer()
				}
			case 1:
				VStack {
					Spacer()
					HStack {
						Spacer()
						Text(Strings.Result.oneItemTitle)
							.frame(width: geometry.size.width * 0.75)
							.font(.system(size: 22))
							.multilineTextAlignment(.center)
						Spacer()
					}
					Spacer()
				}
			default:
				VStack {
					if let firstResult = results.first {
						Text(firstResult.option.title)
							.font(.system(size: 32))
							.multilineTextAlignment(.center)
							.padding()
						Text("\(Int(firstResult.weightedAverage * 100))")
					}
					
					List {
						Section(header: Text("Runners Up")) {
							ForEach(results.dropFirst(), id: \.self) { result in
								HStack {
									Text(result.option.title)
									Spacer()
									Text("\(Int(result.weightedAverage * 100))")
										.foregroundColor(.gray)
								}
							}
						}
					}
				}
				.navigationTitle(Strings.Result.title)
			}
		}
	}
}
