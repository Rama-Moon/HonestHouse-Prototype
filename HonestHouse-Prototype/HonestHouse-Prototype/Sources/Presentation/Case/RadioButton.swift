//
//  RadioButton.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import SwiftUI

struct RadioButton<T: Hashable>: View {
    let label: String
    let value: T
    var isEnabled: Bool = true
    @Binding var selectedValue: T

    var body: some View {
        Button(action: {
            selectedValue = value
        }) {
            HStack(spacing: 12) {
                Image(systemName: selectedValue == value ? "largecircle.fill.circle" : "circle")

                Text(label)
            }
            .foregroundColor(isEnabled ? .hhcolor(color: .text(.secondary)) : .hhcolor(color: .buttonBackground(.secondary)))
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
    }
}

