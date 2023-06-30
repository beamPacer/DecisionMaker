//
//  StaticAttributesViews.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 6/30/23.
//

import SwiftUI

struct EditStaticAttributeView: View {
	@Binding var staticAttribute: StaticAttribute

	var body: some View {
		Form {
			TextField(Strings.StaticAttributes.defaultTitle, text: self.$staticAttribute.title)
			VStack(alignment: .leading) {
				Text(Strings.StaticAttributes.importanceLabel)
				Slider(value: $staticAttribute.importance.value, in: staticAttribute.importance.minimumLimit...staticAttribute.importance.maximumLimit)
			}
		}
		.navigationTitle(Strings.StaticAttributes.editAttributeNavTitle)
	}
}
