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
        // EV 기반 조리개 계산
        var nBase = sqrt(tBase * pow(2.0, ev100))
        // f/2.0 이상 개방 보장
        nBase = max(2.0, min(nBase, lens.minOpenAperture))
        
        // ISO 계산
        var iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        iso = max(100, iso)
        
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    // 셔터 우선 모드: 2~15초 범위에서 샘플링, 조리개는 개방값 고정
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: 2.0...15.0,
            aperture: max(2.0, lens.maxOpenAperture),
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}

