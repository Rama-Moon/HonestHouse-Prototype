//
//  CustomActiveButton.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import SwiftUI

struct CustomActiveButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .font(.system(size: 16, weight: .bold))
                .background(isEnabled ? .hhcolor(color: .buttonBackground(.primary)) : .hhcolor(color: .buttonBackground(.disabled)))
                .foregroundColor(isEnabled ? .hhcolor(color: .buttonText(.primary)) : .hhcolor(color: .buttonText(.disabled)))
                .cornerRadius(12)
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    CustomActiveButton(title: "완료", action: { print("클릭") })
}
