//
//  ResultGraphView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 7/4/23.
//

import SwiftUI
import UIKit

class ResultGraphView: UIView {
	private struct Dimensions {
		static let dotDiameter: Double = 10
		static let dotRadius: Double = dotDiameter / 2
		static let textOffsetFromDotY: Double = dotDiameter * 0.75
		static let margin: CGFloat = 20
		static let verticalPadding: CGFloat = dotDiameter
	}
	
	private struct Colors {
		static func textPrimary(for style: UIUserInterfaceStyle) -> UIColor {
			style == .dark ? .white : .black
		}
		
		static func line(for style: UIUserInterfaceStyle) -> UIColor {
			style == .dark ? .lightGray : .darkGray
		}
		
		static func dot(for style: UIUserInterfaceStyle) -> UIColor {
			style == .dark ? .white : .black
		}
	}
	
	var results: [Result] = [] {
		didSet {
			isAccessibilityElement = true
			setNeedsDisplay()
		}
	}
	
	init(results: [Result]) {
		self.results = results
		super.init(frame: .zero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		guard let context = UIGraphicsGetCurrentContext() else { return }
		
		let style: UIUserInterfaceStyle = traitCollection.userInterfaceStyle
				
		// Draw the vertical line with added padding for the top and bottom
		let lineXPosition = rect.minX + Dimensions.margin
		context.move(to: CGPoint(x: lineXPosition, y: Dimensions.verticalPadding))
		context.addLine(to: CGPoint(x: lineXPosition, y: rect.height - Dimensions.verticalPadding))
		context.setLineWidth(1.0)
		context.setStrokeColor(Colors.line(for: style).cgColor)
		context.strokePath()
		
		var usedFrames: [CGRect] = []
		let maxTextWidth = rect.width - lineXPosition - Dimensions.dotDiameter * 2
		
		// Draw markers for each result
		for result in results {
			// Adjust y position according to the padding
			let yPos = (rect.height - 2 * Dimensions.verticalPadding) - CGFloat(result.percentWeightedAverage) * (rect.height - 2 * Dimensions.verticalPadding) + Dimensions.verticalPadding
			context.setFillColor(Colors.dot(for: style).cgColor)
			context.addEllipse(in: CGRect(
				x: lineXPosition - Dimensions.dotRadius,
				y: yPos - Dimensions.dotRadius,
				width: Dimensions.dotDiameter,
				height: Dimensions.dotDiameter
			))
			context.fillPath()

			let text: NSString = (result.option.title + " " + formattedPercentString(for: result)) as NSString
			let textAttributes: [NSAttributedString.Key: Any] = [
				.font: UIFont.systemFont(ofSize: 16),
				.foregroundColor: Colors.textPrimary(for: style)
			]
			
			var textSize = text.size(withAttributes: textAttributes)
			var textToDisplay: NSString = text

			// Check if the text width exceeds the maximum allowed width
			if textSize.width > maxTextWidth {
				let ellipsis: NSString = "..."
				let ellipsisSize = ellipsis.size(withAttributes: textAttributes)
				// Subtract the width of the ellipsis from the maximum allowed width
				let availableWidth = maxTextWidth - ellipsisSize.width

				// Truncate the text character by character until it fits the available width
				while textSize.width > availableWidth && textToDisplay.length > 0 {
					textToDisplay = textToDisplay.substring(to: textToDisplay.length - 1) as NSString
					textSize = textToDisplay.size(withAttributes: textAttributes)
				}

				// Append the ellipsis to the truncated text
				textToDisplay = (textToDisplay.substring(to: textToDisplay.length - 10) + "... " + formattedPercentString(for: result)) as NSString
			} else {
				textToDisplay = "\(textToDisplay) \(formattedPercentString(for: result))" as NSString
			}

			let textPoint = CGPoint(x: lineXPosition + Dimensions.dotDiameter, y: yPos - Dimensions.textOffsetFromDotY)
			var textFrame = CGRect(origin: textPoint, size: textSize)
		   
			// Check for collisions and adjust frame if necessary
			for usedFrame in usedFrames {
				if textFrame.intersects(usedFrame) {
					textFrame.origin.y = usedFrame.maxY // Move the frame below the existing one
				}
			}
			
			// Add frame to used frames and draw the text
			usedFrames.append(textFrame)
			textToDisplay.draw(in: textFrame, withAttributes: textAttributes)
		}
	}
	
	private func formattedPercentString(for result: Result) -> String {
		"(\(Int(result.percentWeightedAverage * 100))%)"
	}
}

struct ResultSwiftUIView: UIViewRepresentable {
	var results: [Result]

	func makeUIView(context: Context) -> ResultGraphView {
		let view = ResultGraphView(frame: .zero)
		view.backgroundColor = .clear
		view.isAccessibilityElement = true
		view.accessibilityLabel = "results display"
		setAccessibilityValue(on: view)
		view.results = results
		return view
	}

	func updateUIView(_ uiView: ResultGraphView, context: Context) {
		setAccessibilityValue(on: uiView)
		uiView.results = results
	}
	
	private func voiceOverString(for result: Result) -> String {
		"\(result.option.title), \(Int(result.percentWeightedAverage * 100)) percent"
	}
	
	private func setAccessibilityValue(on view: UIView) {
		view.accessibilityValue = results
			.map { voiceOverString(for: $0) }
			.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
	}
}

