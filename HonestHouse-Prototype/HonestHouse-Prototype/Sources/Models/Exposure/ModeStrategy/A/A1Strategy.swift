//
//  A1Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct A1Strategy: ModeStrategy {
    let subtype: ModeSubtype = .A1
    
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> ExposureSetting {
        return baseWithFixedAperture(N: 8.0, ev100: ev100, lens: lens, body: body, isoCap: isoCap)
    }
    
    // f/8~f/11 사이에서 조리개 범위 스펙트럼 생성
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        let base = calculateBase(ev100: ev100, lens: lens, body: body, isoCap: isoCap)
        // base 포함, f/8 → f/11로 닫히는 방향
        return generateApertureSpectrum(
            base: base, apertureRange: 8.0...11.0,
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

