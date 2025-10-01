//
//  MathUtils.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

/// ISO값 산출 공식 (EV계산 공식 참고)
@inline(__always)
func isoFor(ev100: Double, shutter t: Double, aperture N: Double) -> Double {
    return 100.0 * (N * N) / (t * pow(2.0, ev100))
}

/// 값을 최소~최대 범위 안에 강제로 맞추는 함수.
/// 1. min작으면 min으로 올림
/// 2. max보다 크면 max로 내림
/// 3. 그 사이 값이면 그대로 둠.
@inline(__always)
func clamp(_ x: Double, min lo: Double, max hi: Double) -> Double {
    return Swift.max(lo, Swift.min(hi, x))
}

/// 안전 셔터 속도 계산
@inline(__always)
func handHoldLimit(focalLength: Double, cropFactor: Double) -> Double {
    return 1.0 / (focalLength * cropFactor)
}
