//
//  Constants.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import SwiftUI

struct Constants {
    enum Color {
        enum ButtonBackground {
            case disabled, primary, secondary
            var color: SwiftUI.Color {
                switch self {
                case .disabled:
                    SwiftUI.Color(hex: "#F3F4F6")
                case .primary:
                    SwiftUI.Color(hex: "#7E7E7E")
                case .secondary:
                    SwiftUI.Color(hex: "#B0B8C1")
                }
            }
        }
        enum ButtonText {
            case disabled, primary
            var color: SwiftUI.Color {
                switch self {
                case .disabled:
                    SwiftUI.Color(hex: "#7E7E7E")
                case .primary:
                    SwiftUI.Color(hex: "#FFFFFF")
                }
            }
        }
        
        enum Text {
            case primary, secondary, white
            var color: SwiftUI.Color {
                switch self {
                case .primary:
                    SwiftUI.Color(hex: "#000000")
                case .secondary:
                    SwiftUI.Color(hex: "#111111")
                case .white:
                    SwiftUI.Color(hex: "#FFFFFF")
                }
            }
        }
        
        enum Token {
            case buttonBackground(ButtonBackground)
            case buttonText(ButtonText)
            case text(Text)
            
            var color: SwiftUI.Color {
                switch self {
                case .buttonBackground(let buttonBackground): return buttonBackground.color
                case .buttonText(let buttonText): return buttonText.color
                case .text(let text): return text.color
                }
            }
        }
    }
}
