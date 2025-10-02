//
//  BaseValueUtils.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/2/25.
//

import Foundation

/// ISO 보정 (표준 스탑 + cap 제한)
func correctISO(ev100: Double, shutter: Double, aperture: Double, isoCap: Int) -> Int {
    // 현재 조합의 EV (ISO100 기준)
    let evAtCurrent = log2((aperture * aperture) / shutter)
    
    // 필요한 ISO 배율 = 2^(ΔEV)
    let deltaEV = evAtCurrent - ev100   // +값 = 더 밝음, -값 = 더 어두움
    var iso = 100 * pow(2.0, deltaEV) // ISO는 부족한 EV만큼 2배씩 증가
    
    // ISO 범위 제한
    if iso < 100 { iso = 100 }
    if iso > Double(isoCap) { iso = Double(isoCap) }
    
    // 가장 가까운 표준 ISO 선택
    let nearestISO = nearestStop(to: iso, from: isoStops.map { Double($0) }, cap: Double(isoCap))
    return Int(nearestISO)
}

// MARK: - Base값 구하는 함수
/// A 모드 계열: 조리개 고정, 셔터 계산
func baseWithFixedAperture(
    N: Double,
    ev100: Double,
    lens: CameraLens,
    body: CameraBody,
    isoCap: Int
) -> ExposureSetting {
    // 렌즈 지원 범위 내에서 가장 가까운 표준 조리개 값으로 스냅
    let Nclamped = snapApertureToLens(N, lens: lens)
    // EV 식으로 셔터 시간 계산: tRef = N^2 / 2^EV
    let tRef = (Nclamped * Nclamped) / pow(2.0, ev100)
    
    // hand-hold 적용 후, 바디 셔터 스톱으로 스냅
    let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
    let tUsed = min(tRef, tHand)
    
    // 계산된 셔터를 바디가 지원하는 범위 내에서 가장 가까운 값으로 스냅
    let t = snapShutterToBody(tUsed, body: body)
    // ISO 보정: ISO100 기준 EV와의 차이를 계산하여 부족하면 ISO를 끌어올림
    let iso = correctISO(ev100: ev100, shutter: t, aperture: Nclamped, isoCap: isoCap)
    return ExposureSetting(shutter: t, aperture: Nclamped, iso: iso)
}

/// S/M 모드 계열: 셔터 고정, 조리개 계산
func baseWithFixedShutter(
    t: Double,
    ev100: Double,
    lens: CameraLens,
    body: CameraBody,
    isoCap: Int
) -> ExposureSetting {
    // 지정된 셔터 속도를 바디가 지원하는 범위 내에서 스냅
    let tClamped = snapShutterToBody(t, body: body)
    // EV 식으로 조리개 계산: N = sqrt(t * 2^EV)
    let nCalc = sqrt(tClamped * pow(2.0, ev100))
    // 계산된 조리개를 렌즈 지원 범위 내에서 가장 가까운 표준 값으로 스냅
    let N = snapApertureToLens(nCalc, lens: lens)
    // ISO 보정: 부족한 노출은 ISO로 끌어올림
    let iso = correctISO(ev100: ev100, shutter: tClamped, aperture: N, isoCap: isoCap)
    return ExposureSetting(shutter: tClamped, aperture: N, iso: iso)
}
