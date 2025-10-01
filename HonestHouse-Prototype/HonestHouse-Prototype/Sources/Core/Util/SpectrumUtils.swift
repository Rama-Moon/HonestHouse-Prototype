//
//  SpectrumUtils.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

// 1/3스톱 계수
let kApertureThirdStopFactor = pow(2.0, 1.0/6.0) // f-number: 1 stop = √2 → 1/3 stop = 2^(1/6)
let kShutterThirdStopFactor  = pow(2.0, 1.0/3.0) // shutter: 1 stop = ×2 → 1/3 stop = 2^(1/3)

/// 조리개 범위를 일정 스텝(1/3스톱)으로 훑으면서 스펙트럼 생성
func generateApertureSpectrum(
    apertureRange: ClosedRange<Double>, // 조리개 범위
    stepThirdStops: Int, // 몇 스텝 간격?
    ev100: Double,
    lens: CameraLens,
    body: CameraBody,
    isoCap: Int
) -> [ExposureSetting] {
    var out: [ExposureSetting] = []
    let stepFactor = pow(kApertureThirdStopFactor, Double(stepThirdStops))
    var f = apertureRange.lowerBound // 시작 조리개 값

    let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)

    while f <= apertureRange.upperBound + 1e-9 {
        // EV 기반으로 ISO100일 때 셔터속도 계산
        let tRef = (f * f) / pow(2.0, ev100)
        
        // 셔터속도는 EV 기반 값(tRef)와 손떨림 한계(tHand) 중 더 빠른 쪽 채택
        var t = min(tRef, tHand)
        t = clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)

        // ISO 계산 및 보정 (최소 100, 최대 isoCap)
        var iso = isoFor(ev100: ev100, shutter: t, aperture: f)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }

        out.append(ExposureSetting(shutter: t, aperture: f, iso: Int(round(iso))))

        // 다음 1/3스톱 조리개로 이동
        f *= stepFactor
    }
    return out
}

/// 셔터 범위를 일정 스텝(1/3스톱)으로 훑으면서 스펙트럼 생성
func generateShutterSpectrum(
    shutterRange: ClosedRange<Double>, // 셔터 범위
    aperture: Double, // 고정 조리개 값
    stepThirdStops: Int, // 몇 스텝 간격?
    ev100: Double,
    body: CameraBody,
    isoCap: Int
) -> [ExposureSetting] {
    var out: [ExposureSetting] = []
    let stepFactor = pow(kShutterThirdStopFactor, Double(stepThirdStops))
    var t = shutterRange.lowerBound

    while t <= shutterRange.upperBound + 1e-12 {
        // 바디 한계(최단, 최장 셔터 속도)로 제한
        var tClamped = clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)

        // ISO 계산 및 보정
        var iso = isoFor(ev100: ev100, shutter: tClamped, aperture: aperture)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }

        out.append(ExposureSetting(shutter: tClamped, aperture: aperture, iso: Int(round(iso))))

        // 다음 스텝으로 이동
        t *= stepFactor
    }
    return out
}

