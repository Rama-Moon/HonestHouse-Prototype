//
//  SStrategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct SStrategy: ModeStrategy {
    let subtype: ModeSubtype = .S

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        // 빠른 셔터 고정 (1/500초)
        let tBase = clamp(1.0/500.0, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        // 조리개는 f/8 근처 (심도 확보)
        let nBase = clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    // 1/1000~1/500 셔터 범위, 조리개 f/8 고정
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: (1.0/1000.0)...(1.0/500.0),
            aperture: clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture),
            stepThirdStops: 1,
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}


