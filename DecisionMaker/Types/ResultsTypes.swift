//
//  ResultsTypes.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

struct Result: Hashable {
	let option: Option
	let weightedAverage: Float
	var percentWeightedAverage: Float
}
