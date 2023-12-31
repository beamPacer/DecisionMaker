//
//  EmojiHandler.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

struct EmojiHandler {
	static let shared = EmojiHandler()
	
	private var allEmojis: [String: String] = [:]
	private(set) var allEmojisArray: [String] = []
	
	init() {
		let emojiRanges = [
			0x1F600...0x1F64F, // Emoticons
			0x1F300...0x1F5FF, // Miscellaneous Symbols and Pictographs
			0x1F680...0x1F6FF, // Transport and Map Symbols
			0x1F700...0x1F77F, // Alchemical Symbols
			0x1F780...0x1F7FF, // Geometric Shapes Extended
			0x1F800...0x1F8FF, // Supplemental Arrows-C
			0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
			0x1FA00...0x1FA6F, // Chess Symbols
			0x1FA70...0x1FAFF, // Symbols and Pictographs Extended-A
			0x2600...0x26FF,   // Miscellaneous Symbols
			0x2700...0x27BF,   // Dingbats
			0x1F1E6...0x1F1FF, // Flags (iOS 9.0 and later)
		]

		for range in emojiRanges {
			for unicode in range {
				if let scalar = UnicodeScalar(unicode) {
					let emoji = String(scalar)
					guard Character(emoji).unicodeAvailable() else {
						continue
					}
					
					let cfstr = NSMutableString(string: emoji) as CFMutableString
					var range = CFRangeMake(0, CFStringGetLength(cfstr))
					CFStringTransform(cfstr, &range, kCFStringTransformToUnicodeName, false)
					allEmojis[cfstr as String] = emoji
					allEmojisArray.append(emoji)
				}
			}
		}
	}
	
	func emojis(for searchString: String, completion: @escaping ([String]) -> Void) {
		DispatchQueue.global(qos: .userInitiated).async {
			let searchTerms: [String] = self.getSearchTerms(for: searchString)
			var candidates: [String] = []
			for key in self.allEmojis.keys {
				for searchTerm in searchTerms {
					if key.contains(searchTerm), let value = self.allEmojis[key], !candidates.contains(value) {
						candidates.append(value)
					}
				}
			}
			DispatchQueue.main.async {
				completion(candidates.sorted().reversed())
			}
		}
	}

	
	func emoji(for searchString: String) -> String? {
		let searchTerms: [String] = getSearchTerms(for: searchString)
		var candidates: [String: Int] = [:]
		for key in allEmojis.keys {
			for searchTerm in searchTerms {
				if key.contains(searchTerm) {
					if var value = candidates[key] {
						value += 1
						candidates[key] = value
					} else {
						candidates[key] = 1
					}
				}
			}
		}
		
		let candidateKeys: [String] = candidates
			.sorted { $0.value > $1.value }
			.map { $0.key }
		
		guard let firstCandidate = candidateKeys.first else {
			return nil
		}
		
		return allEmojis[firstCandidate]
	}
	
	func getSearchTerms(for searchString: String) -> [String] {
		searchString
			.split(separator: " ")
			.map { String($0).uppercased() }
	}
}
