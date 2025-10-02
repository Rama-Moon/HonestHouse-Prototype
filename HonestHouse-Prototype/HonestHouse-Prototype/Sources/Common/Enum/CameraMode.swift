//
//  CameraMode.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/2/25.
//

enum CameraMode {
    case AMode
    case SMode
    case MMode
    
    var title: String {
        switch self {
        case .AMode:
            return "A Mode"
        case .SMode:
            return "S Mode"
        case .MMode:
            return "M Mode"
        }
    }
}
