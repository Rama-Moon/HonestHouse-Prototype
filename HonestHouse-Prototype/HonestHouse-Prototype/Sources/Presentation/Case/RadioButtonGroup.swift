//
//  RadioButtonGroup.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import SwiftUI

struct RadioButtonGroup<T: Hashable & RawRepresentable>: View where T.RawValue == String {
    let title: String
    let options: [T]
    @Binding var selected: T?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))

            HStack {
                ForEach(options, id: \.self) { option in
                    RadioButton(label: option.rawValue, value: option, selectedValue: $selected)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
