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
    let maxOpenAperture: Double // 최대 개방 - N_min
    let minOpenAperture: Double = 16.0 // 최소 조리개 - N_max
    let focalLength: Double
}
