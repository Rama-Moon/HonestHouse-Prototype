//
//  CameraLens.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation

struct CameraLens: Identifiable, Equatable {
    var id = UUID()
    let name: String
    let maxOpenAperture: Float
    let minOpenAperture: Float = 16.0
    let focalLength: Double
}
