//
//  EmojiHandlerTests.swift
//  DecisionMakerTests
//
//  Created by Emma Sinclair on 6/30/23.
//

@testable import DecisionMaker
import XCTest

final class EmojiHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	// Basic functionality

    func testInit() throws {
		let _: EmojiHandler = EmojiHandler()
    }

    func testPerformance_init() throws {
        self.measure {
			let _: EmojiHandler = EmojiHandler()
        }
    }
	
	func testPerformance_lookup() throws {
		let emojiHandler: EmojiHandler = EmojiHandler.shared
		let searchString: String = "house buying"
		self.measure {
			let _: String? = emojiHandler.emoji(for: searchString)
		}
	}
	
	// Selecting an emoji
	
	func testGetEmojiForString_nothingFound() {
		let emojiHandler = EmojiHandler()
		let searchString: String = "gfhdbsjlfl"
		let emoji: String? = emojiHandler.emoji(for: searchString)
		
		XCTAssertEqual(emoji, nil)
	}
	
	func testGetEmojiForString_house() {
		let emojiHandler = EmojiHandler()
		let searchString: String = "house buying"
		let emoji: String? = emojiHandler.emoji(for: searchString)
		
		print("output for \(searchString): \(emoji!)")
		XCTAssertTrue([
			"🏡",
			"🏠",
			"🏚️",
			"🏘",
			"⛯"
		].contains(emoji))
	}
	
	// Search terms
	
	func testGetSearchTerms_shortTerms() {
		let emojiHandler = EmojiHandler()
		let search: String = "ca b"
		let searchTerms = emojiHandler.getSearchTerms(for: search)
		XCTAssertEqual(searchTerms.count, 1)
		XCTAssertEqual(searchTerms, ["CA"])
	}
}
