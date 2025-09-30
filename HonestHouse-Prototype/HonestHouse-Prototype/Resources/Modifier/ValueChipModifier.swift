//
//  ValueChipModifier.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI

struct ValueChipModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .foregroundColor(.black)
    }
}

extension View {
    func valueChipStyle() -> some View {
        modifier(ValueChipModifier())
    }
}
