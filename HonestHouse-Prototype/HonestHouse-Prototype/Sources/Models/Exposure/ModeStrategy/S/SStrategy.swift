//
//  SStrategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct SStrategy: ModeStrategy {
    let subtype: ModeSubtype = .S
    
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> ExposureSetting {
        return baseWithFixedShutter(t: 1.0/500.0, ev100: ev100, lens: lens, body: body, isoCap: isoCap)
    }
    
    // 1/1000~1/500 셔터 범위, 조리개 f/8 고정
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


