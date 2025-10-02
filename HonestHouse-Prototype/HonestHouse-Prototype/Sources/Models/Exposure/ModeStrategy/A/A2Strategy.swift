//
//  A2Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct A2Strategy: ModeStrategy {
    let subtype: ModeSubtype = .A2
    
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> ExposureSetting {
        return baseWithFixedAperture(N: max(2.8, lens.maxOpenAperture), ev100: ev100, lens: lens, body: body, isoCap: isoCap)
    }
    
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        let base = calculateBase(ev100: ev100, lens: lens, body: body, isoCap: isoCap)
        let low = max(2.8, lens.maxOpenAperture)
        let high = min(5.6, lens.minOpenAperture)
        return generateApertureSpectrum(
            base: base, apertureRange: low...high,
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

