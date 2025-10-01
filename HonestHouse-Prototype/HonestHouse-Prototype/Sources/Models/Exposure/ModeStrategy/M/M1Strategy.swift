//
//  M1Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct M1Strategy: ModeStrategy {
    let subtype: ModeSubtype = .M1

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        // 최소 1/500 보장 (빠른 셔터)
        let tBase = clamp(1.0/500.0, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        // 조리개 최대 개방
        let nBase = lens.maxOpenAperture
        // ISO 계산 (EV 기반)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    // 권장 스펙트럼: 셔터 범위에서 약간의 여유 제공 (1/1000 ~ 1/500)
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: (1.0/1000.0)...(1.0/500.0),
            aperture: lens.maxOpenAperture,
            stepThirdStops: 1,
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}

