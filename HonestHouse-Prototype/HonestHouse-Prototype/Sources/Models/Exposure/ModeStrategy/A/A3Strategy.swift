//
//  A3Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct A3Strategy: ModeStrategy {
    let subtype: ModeSubtype = .A3
    
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> ExposureSetting {
        return baseWithFixedAperture(N: 8.0, ev100: ev100, lens: lens, body: body, isoCap: isoCap)
    }
    
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        let base = calculateBase(ev100: ev100, lens: lens, body: body, isoCap: isoCap)
        return generateApertureSpectrum(
            base: base, apertureRange: 8.0...11.0,
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

