//
//  SunStatus.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 10/1/25.
//

import Foundation

public enum SunStatus: Equatable {
    case sunUp(elevation: Double, azimuth: Double)
    case noSun
    
    public var isSunUp: Bool {
        if case .sunUp = self { return true }
        return false
    }
}
