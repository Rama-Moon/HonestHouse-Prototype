//
//  SpectrumUtils.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

// 셔터스피드 스탑 (1/8000 ~ 30초)
let shutterStops: [Double] = [
    1.0/8000, 1.0/6400, 1.0/5000, 1.0/4000,
    1.0/3200, 1.0/2500, 1.0/2000, 1.0/1600,
    1.0/1250, 1.0/1000, 1.0/800,  1.0/640,
    1.0/500,  1.0/400,  1.0/320,  1.0/250,
    1.0/200,  1.0/160,  1.0/125,  1.0/100,
    1.0/80,   1.0/60,   1.0/50,   1.0/40,
    1.0/30,   1.0/25,   1.0/20,   1.0/15,
    1.0/13,   1.0/10,   1.0/8,    1.0/6,
    1.0/5,    1.0/4,    1.0/3,    0.4,
    0.5, 1.0, 1.3, 1.6, 2.0,
    2.5, 3.2, 4.0, 5.0, 6.0,
    8.0, 10.0, 13.0, 15.0, 20.0,
    25.0, 30.0
]

// 조리개 스탑 (f/1.0 ~ f/16)
let apertureStops: [Double] = [
    1.0, 1.1, 1.2, 1.4,
    1.6, 1.8, 2.0, 2.2,
    2.5, 2.8, 3.2, 3.5,
    4.0, 4.5, 5.0, 5.6,
    6.3, 7.1, 8.0, 9.0,
    10.0, 11.0, 13.0, 14.0, 16.0
]

// ISO 스탑 (ISO 100 ~ 25600)
let isoStops: [Int] = [
    100, 125, 160, 200,
    250, 320, 400, 500,
    640, 800, 1000, 1250,
    1600, 2000, 2500, 3200,
    4000, 5000, 6400, 8000,
    10000, 12800, 16000, 20000, 25600
]

/// 주어진 값에 가장 가까운 스탑 인덱스 찾기
func nearestStopIndex(value: Double, stops: [Double]) -> Int {
    var nearestIndex = 0
    var minDiff = Double.greatestFiniteMagnitude
    for (i, s) in stops.enumerated() {
        let diff = abs(s - value)
        if diff < minDiff {
            minDiff = diff
            nearestIndex = i
        }
    }
    return nearestIndex
}

/// 주어진 값과 가장 가까운 스탑 선택
func nearestStop(to value: Double, from stops: [Double], cap: Double? = nil) -> Double {
    let filtered = cap != nil ? stops.filter { $0 <= cap! } : stops
    return filtered.min(by: { abs($0 - value) < abs($1 - value) }) ?? value
}

/// 조리개 범위를 일정 스텝으로 훑으면서 스펙트럼 생성
func generateApertureSpectrum(
    apertureRange: ClosedRange<Double>,
    ev100: Double,
    lens: CameraLens,
    body: CameraBody,
    isoCap: Int
) -> [ExposureSetting] {
    var out: [ExposureSetting] = []

    // 범위 안에 들어가는 스탑만 추출
    let stopsInRange = apertureStops.filter { apertureRange.contains($0) }

    let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)

    for f in stopsInRange {
        // EV 기반 셔터
        let tRef = (f * f) / pow(2.0, ev100)
        var t = min(tRef, tHand)
        t = clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        
        // 표준 스탑 근사값
        let nearestAperture = nearestStop(to: f, from: apertureStops)
        let nearestShutter  = nearestStop(to: t, from: shutterStops)

        var iso = isoFor(ev100: ev100, shutter: t, aperture: f)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }
        
        // 가장 가까운 표준 ISO 선택
        let nearestISO = nearestStop(to: iso, from: isoStops.map { Double($0) }, cap: Double(isoCap))

        out.append(ExposureSetting(shutter: nearestShutter, aperture: nearestAperture, iso: Int(nearestISO)))
    }

    return out
}

/// 셔터 범위를 일정 스텝으로 훑으면서 스펙트럼 생성
func generateShutterSpectrum(
    shutterRange: ClosedRange<Double>,
    aperture: Double, // 초기값 (무시해도 됨, EV 기반으로 다시 계산)
    ev100: Double,
    body: CameraBody,
    isoCap: Int
) -> [ExposureSetting] {
    var out: [ExposureSetting] = []

    // 범위 안에 들어가는 스탑만 추출
    let stopsInRange = shutterStops.filter { shutterRange.contains($0) }

    for t in stopsInRange {
        let tClamped = clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)

        // EV 기반으로 조리개 역산
        let nCalc = sqrt(tClamped * pow(2.0, ev100))
        let nearestAperture = nearestStop(to: nCalc, from: apertureStops)

        // ISO 계산
        var iso = isoFor(ev100: ev100, shutter: tClamped, aperture: nearestAperture)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }

        let nearestISO = nearestStop(to: iso, from: isoStops.map { Double($0) }, cap: Double(isoCap))

        // 표준화된 스탑 조합 추가
        out.append(
            ExposureSetting(
                shutter: nearestStop(to: tClamped, from: shutterStops),
                aperture: nearestAperture,
                iso: Int(nearestISO)
            )
        )
    }

    return out
}


