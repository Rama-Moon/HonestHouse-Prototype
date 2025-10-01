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
        // EV 기반 조리개 계산
        var nBase = sqrt(tBase * pow(2.0, ev100))
        // 심도 확보 → f/8 근처로 강제 - 일단 보고!!!
        nBase = clamp(nBase, min: lens.maxOpenAperture, max: lens.minOpenAperture)
        
        // ISO 계산
        var iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        iso = max(100, iso)
        
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    // 1/1000~1/500 셔터 범위, 조리개 f/8 고정
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: (1.0/1000.0)...(1.0/500.0),
            aperture: clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture),
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}


