//
//  SpectrumUtils.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

// MARK: - 표준 스탑 정의
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

// MARK: - 표준 스탑 스냅 처리 함수
/// 주어진 값과 가장 가까운 스탑 선택
func nearestStop(to value: Double, from stops: [Double], cap: Double? = nil) -> Double {
    let filtered = cap != nil ? stops.filter { $0 <= cap! } : stops
    return filtered.min(by: { abs($0 - value) < abs($1 - value) }) ?? value
}

/// 렌즈 범위 내에서 조리개 표준스톱 스냅까지 수행
func snapApertureToLens(_ N: Double, lens: CameraLens) -> Double {
    let cand = apertureStops.filter { $0 >= lens.maxOpenAperture && $0 <= lens.minOpenAperture }
    return nearestStop(to: clamp(N, min: lens.maxOpenAperture, max: lens.minOpenAperture), from: cand)
}

/// 바디 범위 내에서 셔터스피드 표준스톱 스냅까지 수행
func snapShutterToBody(_ t: Double, body: CameraBody) -> Double {
    let cand = shutterStops.filter { $0 >= body.fastestShutterSpeed && $0 <= body.slowestShutterSpeed }
    return nearestStop(to: clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed), from: cand)
}

// MARK: - 스펙트럼 구하는 함수
/// 조리개 범위를 일정 스텝으로 훑으면서 스펙트럼 생성
func generateApertureSpectrum(
    base: ExposureSetting,
    apertureRange: ClosedRange<Double>,
    ev100: Double,
    lens: CameraLens,
    body: CameraBody,
    isoCap: Int
) -> [ExposureSetting] {
    var out: [ExposureSetting] = []
    let eps = 1e-6

    // 후보 조리개 값 = 렌즈 범위 ∩ 요청된 범위
    let minN = max(lens.maxOpenAperture, apertureRange.lowerBound)
    let maxN = min(lens.minOpenAperture, apertureRange.upperBound)
    let cand = apertureStops.filter { f in
        f + eps >= minN && f - eps <= maxN
    }

    for f in cand {
        // EV 기반으로 셔터 계산
        let tRef = (f * f) / pow(2.0, ev100)
        
        // 손떨림 한계와 비교 -> 더 빠른 쪽 사용
        let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
        var t = min(tRef, tHand)
        
        // 바디가 지원하는 셔터 범위 내로 clamp
        t = clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)

        // 표준 스탑 근사
        let nearestAperture = nearestStop(to: f, from: apertureStops)
        let nearestShutter  = nearestStop(to: t, from: shutterStops)

        // ISO 보정
        let iso = correctISO(ev100: ev100, shutter: nearestShutter, aperture: nearestAperture, isoCap: isoCap)

        out.append(ExposureSetting(shutter: nearestShutter, aperture: nearestAperture, iso: iso))
    }
    return out
}

/// 셔터 범위를 일정 스텝으로 훑으면서 스펙트럼 생성
func generateShutterSpectrum(
    base: ExposureSetting,
    shutterRange: ClosedRange<Double>,
    ev100: Double,
    lens: CameraLens,
    body: CameraBody,
    isoCap: Int
) -> [ExposureSetting] {
    var out: [ExposureSetting] = []
    let eps = 1e-6

    // 후보 셔터 값 선택(바디 지원 범위, 파라미터 범위 교집합) -> limit 범위 안전하게 보정
    let minT = max(body.fastestShutterSpeed, min(shutterRange.lowerBound, shutterRange.upperBound))
    let maxT = min(body.slowestShutterSpeed, max(shutterRange.lowerBound, shutterRange.upperBound))

    let cand = shutterStops.filter { t in
        t + eps >= minT && t - eps <= maxT
    }

    for t in cand {
        let tClamped = clamp(t, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)

        // EV 기반으로 조리개 역산 → 렌즈 범위 내에서 스냅
        let nCalc = sqrt(tClamped * pow(2.0, ev100))
        let nearestAperture = snapApertureToLens(nCalc, lens: lens)

        // ISO 보정
        let iso = correctISO(ev100: ev100, shutter: tClamped, aperture: nearestAperture, isoCap: isoCap)

        // 표준 스탑으로 정리
        let nearestShutter  = nearestStop(to: tClamped, from: shutterStops)

        out.append(ExposureSetting(shutter: nearestShutter, aperture: nearestAperture, iso: iso))
    }
    return out
}



