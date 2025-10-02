//
//  M1Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct M1Strategy: ModeStrategy {
    let subtype: ModeSubtype = .M1
    
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> ExposureSetting {
        return baseWithFixedShutter(t: 1.0/500.0, ev100: ev100, lens: lens, body: body, isoCap: isoCap)
    }
    
    // 권장 스펙트럼: 셔터 범위에서 약간의 여유 제공 (1/1000 ~ 1/500)
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        let base = calculateBase(ev100: ev100, lens: lens, body: body, isoCap: isoCap)
        return generateShutterSpectrum(
            base: base, shutterRange: (1.0/1000.0)...(1.0/500.0),
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

