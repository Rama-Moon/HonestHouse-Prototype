//
//  ShapeStyle+Extension.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import SwiftUI

extension ShapeStyle where Self == SwiftUI.Color {
    static func hhcolor(color token: Constants.Color.Token) -> Self {
        token.color
    }
}
