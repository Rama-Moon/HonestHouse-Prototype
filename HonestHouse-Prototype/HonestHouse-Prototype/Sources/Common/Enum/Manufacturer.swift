//
//  Manufacturer.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation

enum Manufacturer: String, CaseIterable, Identifiable {
    case canon = "Canon"
    case sony = "SONY"
    case nikon = "Nikon"
    
    var id: String { rawValue }
}

// For CameraItem Selection
extension Manufacturer {
    var bodies: [CameraBody] {
        switch self {
        case .canon: return CanonItems.bodies
        case .sony:  return SonyItems.bodies
        case .nikon: return NikonItems.bodies
        }
    }

    var lenses: [CameraLens] {
        switch self {
        case .canon: return CanonItems.lenses
        case .sony:  return SonyItems.lenses
        case .nikon: return NikonItems.lenses
        }
    }
}
