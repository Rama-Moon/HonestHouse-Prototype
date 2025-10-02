//
//  M2Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct M2Strategy: ModeStrategy {
    let subtype: ModeSubtype = .M2
    
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> ExposureSetting {
        return baseWithFixedShutter(t: 2.0, ev100: ev100, lens: lens, body: body, isoCap: isoCap)
    }
    
    // 셔터 우선 모드: 2~15초 범위에서 샘플링, 조리개는 개방값 고정
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        let base = calculateBase(ev100: ev100, lens: lens, body: body, isoCap: isoCap)
        return generateShutterSpectrum(
            base: base, shutterRange: 2.0...15.0,
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

