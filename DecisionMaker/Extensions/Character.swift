//
//  Character.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 7/4/23.
//

import UIKit

extension Character {
	private static let refUnicodeSize: CGFloat = 8
	private static let refUnicodePng =
		Character("\u{1fff}").png(ofSize: Character.refUnicodeSize)

	func unicodeAvailable() -> Bool {
		if let refUnicodePng = Character.refUnicodePng,
			let myPng = self.png(ofSize: Character.refUnicodeSize) {
			return refUnicodePng != myPng
		}
		return false
	}
	
	private func png(ofSize fontSize: CGFloat) -> Data? {
		let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
		let charStr = "\(self)" as NSString
		let size = charStr.size(withAttributes: attributes)

		UIGraphicsBeginImageContext(size)
		
		charStr.draw(at: CGPoint(x: 0,y :0), withAttributes: attributes)

		var png: Data? = nil
		if let charImage = UIGraphicsGetImageFromCurrentImageContext() {
			png = charImage.pngData()
		}

		UIGraphicsEndImageContext()
		
		return png
	}
}
