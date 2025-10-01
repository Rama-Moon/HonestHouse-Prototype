//
//  A1Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct A1Strategy: ModeStrategy {
    let subtype: ModeSubtype = .A1

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        // 풍경: f/8 기본값
        let nBase = clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture)
        // EV 기반 셔터 속도 계산
        let tRef = (nBase * nBase) / pow(2.0, ev100)
        // 손떨림 방지 한계
        let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
        // 더 빠른 쪽 선택 (흔들림 방지 우선)
        let tBase = min(tRef, tHand)
        // ISO 계산 (EV 기반)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    // f/8~f/11 사이에서 조리개 범위 스펙트럼 생성
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
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

