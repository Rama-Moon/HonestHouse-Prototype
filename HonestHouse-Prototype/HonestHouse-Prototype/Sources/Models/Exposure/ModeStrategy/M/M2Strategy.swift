//
//  M2Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct M2Strategy: ModeStrategy {
    let subtype: ModeSubtype = .M2

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        // 느린 셔터 고정
        let tBase = clamp(2.0, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        // 가능한 한 개방 (최소 f/2.0 보장)
        let nBase = max(2.0, lens.maxOpenAperture)
        // ISO 계산 (EV 기반)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    // 셔터 우선 모드: 2~15초 범위에서 샘플링, 조리개는 개방값 고정
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: 2.0...15.0,
            aperture: max(2.0, lens.maxOpenAperture),
            stepThirdStops: 1,
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}

