//
//  DecisionMakerTests.swift
//  DecisionMakerTests
//
//  Created by Emma Sinclair on 6/17/23.
//

import XCTest
@testable import DecisionMaker

final class TypesTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
	
	// Test that data loads

    func testExampleDataLoadsTitle() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		XCTAssertEqual(exampleData.title, "minimumSetup")
    }
	
	func testExampleDataLoadsStaticAttributes() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		XCTAssertEqual(exampleData.staticAttributes.count, 1)
	}
	
	func testExampleDataLoadsCorrectStaticAttributes() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		let firstAttribute: StaticAttribute = exampleData.staticAttributes.first!
		XCTAssertEqual(firstAttribute.title, "oneAttribute")
		XCTAssertEqual(firstAttribute.importance, BoundFloat(0.5))
	}
	
	func testExampleDataLoadsOptions() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		XCTAssertEqual(exampleData.options.count, 2)
	}
	
	func testExampleDataLoadsCorrectOptionsTitles() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		let firstOption: Option = exampleData.options.first!
		let lastOption: Option = exampleData.options.last!
		XCTAssertEqual(firstOption.title, "a")
		XCTAssertEqual(lastOption.title, "b")
	}
	
	func testExampleDataLoadsCorrectOptionAttributes() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		let firstAttribute: StaticAttribute = exampleData.staticAttributes.first!
		let firstOption: Option = exampleData.options.first!
		let firstOptionFirstAttribute: OptionAttribute = firstOption.getOptionAttribute(for: firstAttribute)
		let lastOption: Option = exampleData.options.last!
		let lastOptionFirstAttribute: OptionAttribute = lastOption.getOptionAttribute(for: firstAttribute)
		
		XCTAssertEqual(firstOptionFirstAttribute.value, "oneAttributeValue1")
		XCTAssertEqual(firstOptionFirstAttribute.goodness, BoundFloat(0.25))
		
		XCTAssertEqual(lastOptionFirstAttribute.value, "oneAttributeValue2")
		XCTAssertEqual(lastOptionFirstAttribute.goodness, BoundFloat(0.75))
	}
	
	// Test weighted average calculation
	
	func testGetResults() throws {
		let exampleData: Decision = ExampleData.minimumOptions
		let results: [Result] = exampleData.getResults()
		
		XCTAssertEqual(results.count, 2)
		XCTAssertEqual(results.first!.weightedAverage, 0.375)
		XCTAssertEqual(results.first!.option.title, "b")
		XCTAssertEqual(results.last!.weightedAverage, 0.125)
		XCTAssertEqual(results.last!.option.title, "a")
	}
	
	func testGetResults_greaterThan1Average() throws {
		let exampleData: Decision = ExampleData.minimumOptions_greaterThan1Average
		let results: [Result] = exampleData.getResults()
		
		XCTAssertEqual(results.count, 2)
		XCTAssertEqual(results.first!.weightedAverage, 1.25)
		XCTAssertEqual(results.first!.option.title, "a")
		XCTAssertEqual(results.last!.weightedAverage, 1.125)
		XCTAssertEqual(results.last!.option.title, "b")
	}
	
	func testGetWeightedAverage_greaterThan1Average() throws {
		let exampleData: Decision = ExampleData.minimumOptions_greaterThan1Average
		let option1: Option = exampleData.options.first!
		let option2: Option = exampleData.options.last!
		
		let option1WeightedAverage: Float = exampleData.getWeightedAverage(for: option1)
		let option2WeightedAverage: Float = exampleData.getWeightedAverage(for: option2)
		
		XCTAssertEqual(option1WeightedAverage, 1.25)
		XCTAssertEqual(option2WeightedAverage, 1.125)
	}
}
