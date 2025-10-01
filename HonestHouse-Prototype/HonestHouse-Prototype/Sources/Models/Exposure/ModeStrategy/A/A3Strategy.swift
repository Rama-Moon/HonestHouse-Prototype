//
//  A3Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct A3Strategy: ModeStrategy {
    let subtype: ModeSubtype = .A3

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        // 기본적으로 풍경과 동일 → f/8 기준
        let nBase = clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture)
        let tRef = (nBase * nBase) / pow(2.0, ev100)
        let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
        let tBase = min(tRef, tHand)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        // f/8~11 범위에서 조리개 스펙트럼 생성
        return generateApertureSpectrum(
            apertureRange: 8.0...11.0,
            stepThirdStops: 1,
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

