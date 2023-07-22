//
//  StaticAttributeTypes.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import Foundation

class StaticAttribute: ObservableObject, Codable {
	var id = UUID()
	@Published var title: String
	@Published var importance: BoundFloat
	@Published var emoji: String

	init(title: String = "", importance: BoundFloat = BoundFloat(0), emoji: String? = nil) {
		self.title = title
		self.importance = importance
		self.emoji = emoji != nil ? emoji! : EmojiHandler.shared.emoji(for: title) ?? Strings.Common.defaultEmoji
	}
	
	// MARK: Codable conformance

	enum CodingKeys: CodingKey {
		case id, title, importance, emoji
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let stringTitle = try container.decode(String.self, forKey: .title)
		id = try container.decode(UUID.self, forKey: .id)
		title = stringTitle
		importance = try container.decode(BoundFloat.self, forKey: .importance)
		do {
			emoji = try container.decode(String.self, forKey: .emoji)
		} catch {
			emoji = EmojiHandler.shared.emoji(for: stringTitle) ?? Strings.Common.defaultEmoji
		}
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(importance, forKey: .importance)
		try container.encode(emoji, forKey: .emoji)
	}
}

// MARK: Identifiable conformance

extension StaticAttribute: Identifiable {
	static func == (lhs: StaticAttribute, rhs: StaticAttribute) -> Bool {
		lhs.id == rhs.id
	}
}

// MARK: Hashable conformance

extension StaticAttribute: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

// MARK: CustomStringConvertible conformance

extension StaticAttribute: CustomStringConvertible {
	var description: String {
		"StaticAttribute("
		+ "\"\(title)\""
		+ ", "
		+ "\(importance.description)"
		+ ")"
	}
}

