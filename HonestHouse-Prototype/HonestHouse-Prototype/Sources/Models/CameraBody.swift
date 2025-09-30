//
//  CameraBody.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation

struct CameraBody: Identifiable, Equatable {
    var id = UUID()
    let name: String
    let fastestShutterSpeed: Double // 초 단위 (1/8000s → 0.000125)
    let slowestShutterSpeed: Double // 초 단위 (30s → 30.0)
}
