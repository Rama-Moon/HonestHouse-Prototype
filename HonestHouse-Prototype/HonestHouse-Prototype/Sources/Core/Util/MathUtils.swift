//
//  MathUtils.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

@inline(__always)
func isoFor(ev100: Double, shutter t: Double, aperture N: Double) -> Double {
    return 100.0 * (N * N) / (t * pow(2.0, ev100))
}

@inline(__always)
func clamp(_ x: Double, min lo: Double, max hi: Double) -> Double {
    return Swift.max(lo, Swift.min(hi, x))
}

@inline(__always)
func handHoldLimit(focalLength: Double, cropFactor: Double) -> Double {
    return 1.0 / (focalLength * cropFactor)
}

let kApertureThirdStopFactor = pow(2.0, 1.0/6.0) // f 넘버 1/3스톱
let kShutterThirdStopFactor  = pow(2.0, 1.0/3.0) // 셔터 1/3스톱
