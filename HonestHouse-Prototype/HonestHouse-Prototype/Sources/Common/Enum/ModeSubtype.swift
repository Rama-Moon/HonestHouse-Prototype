//
//  ModeSubtype.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

enum ModeSubtype: String {
    case M1, M2           // Manual
    case A1, A2, A3       // Aperture priority
    case S                // Shutter priority

    var anchor: AnchorMode {
        switch self {
        case .M1, .M2, .S:
            return .shutter
        case .A1, .A2, .A3:
            return .aperture
        }
    }
    
    /// 최상위 모드 귀결
    var parentMode: CameraMode {
        switch self {
        case .M1, .M2:
            return .MMode
        case .A1, .A2, .A3:
            return .AMode
        case .S:
            return .SMode
        }
    }
}
