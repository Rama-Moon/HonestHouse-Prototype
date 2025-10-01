//
//  CameraLens.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation
import SwiftData

@Model
class CameraLens: Identifiable, Equatable {
    var id = UUID()
    let name: String
    let maxOpenAperture: Float
    
    init(id: UUID = UUID(), name: String, maxOpenAperture: Float) {
        self.id = id
        self.name = name
        self.maxOpenAperture = maxOpenAperture
    }
}
