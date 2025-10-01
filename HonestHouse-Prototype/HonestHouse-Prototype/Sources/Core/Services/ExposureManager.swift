//
//  ExposureManager.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation
import SwiftUI

final class ExposureManager {
    
    // MARK: - Public API
    func recommendExposure(
        body: CameraBody,
        lens: CameraLens,
        intent: Intent,
        ev100: Double,
        isoCap: Int,
        evBacklightBias: Double
    ) -> (mode: RecommendedMode, base: ExposureSetting, spectrum: [ExposureSetting]) {
        
        let evEff = ev100 - evBacklightBias
        let tHand = 1.0 / lens.focalLength
        
        // 1) 추천 모드 결정
        let mode = decideRecommendedMode(intent: intent)
        
        // 2) 추천 모드 → 앵커 매핑
        let anchor = mode.anchor
        
        // 2) Base 계산
        let (tBase, nBase) = calculateBase(
            anchor: anchor,
            body: body,
            lens: lens,
            intent: intent,
            evEff: evEff,
            tHand: tHand
        )
        
        // 3) ISO 계산
        var isoBase = calculateISO(evEff: evEff, shutter: tBase, aperture: nBase)
        isoBase = clampISO(isoBase, isoCap: isoCap)
        
        let base = ExposureSetting(
            shutter: tBase,
            aperture: nBase,
            iso: Int(round(isoBase))
        )
        
        // 4) 스펙트럼 생성
        let spectrum = generateSpectrum(
            anchor: anchor,
            baseShutter: tBase,
            baseAperture: nBase,
            evEff: evEff,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
        
        return (mode, base, spectrum)
    }
    
    // MARK: - Private Steps
    private func decideRecommendedMode(intent: Intent) -> RecommendedMode {
        if intent.subject == "people" && intent.motion == "dynamic" && intent.dof {
            return .manual   // 얕은 심도 + 빠른 셔터 동시 제어 필요
        } else if intent.subject == "people" && intent.motion == "dynamic" {
            return .shutterPriority // 움직임 포착
        } else if intent.subject == "people" && intent.motion == "static" && intent.dof {
            return .aperturePriority // 얕은 심도 포트레이트
        } else if intent.subject == "landscape" {
            return .aperturePriority // 풍경, 심도 확보
        } else {
            return .shutterPriority // 기본 fallback
        }
    }
    
    private func calculateBase(
        anchor: AnchorMode,
        body: CameraBody,
        lens: CameraLens,
        intent: Intent,
        evEff: Double,
        tHand: Double
    ) -> (Double, Double) {
        var tBase: Double = 1/125.0
        var nBase: Double = 2.8
        
        if anchor == .shutter {
            if intent.motion == "dynamic" && intent.subject == "people" {
                tBase = 1.0/250.0
            } else {
                tBase = max(1.0/40.0, tHand)
            }
            tBase = clamp(tBase, min: body.slowestShutterSpeed, max: body.fastestShutterSpeed)
            nBase = intent.dof ? max(lens.maxOpenAperture, 2.0) : 8.0
        } else {
            if intent.subject == "landscape" {
                nBase = min(8.0, lens.minOpenAperture)
            } else {
                nBase = max(lens.maxOpenAperture, 2.8)
            }
            let tRef = pow(nBase, 2) / pow(2.0, evEff)
            let tGuard = (intent.subject == "people") ? max(1.0/60.0, tHand) : tHand
            tBase = max(tRef, tGuard)
            tBase = clamp(tBase, min: body.slowestShutterSpeed, max: body.fastestShutterSpeed)
        }
        
        return (tBase, nBase)
    }
    
    private func calculateISO(evEff: Double, shutter: Double, aperture: Double) -> Double {
        return 100.0 * pow(aperture, 2) / (shutter * pow(2.0, evEff))
    }
    
    private func clampISO(_ iso: Double, isoCap: Int) -> Double {
        var result = iso
        if result < 100 { result = 100 }
        if result > Double(isoCap) { result = Double(isoCap) }
        return result
    }
    
    private func generateSpectrum(
        anchor: AnchorMode,
        baseShutter: Double,
        baseAperture: Double,
        evEff: Double,
        lens: CameraLens,
        body: CameraBody,
        isoCap: Int
    ) -> [ExposureSetting] {
        var spectrum: [ExposureSetting] = []
        let steps = [-2,-1,0,1,2]
        
        for evShift in steps {
            if anchor == .shutter {
                let n = baseAperture * pow(sqrt(2.0), Double(evShift))
                if n < lens.maxOpenAperture || n > lens.minOpenAperture { continue }
                let iso = calculateISO(evEff: evEff, shutter: baseShutter, aperture: n)
                if iso > 0 && iso <= Double(isoCap) {
                    spectrum.append(
                        ExposureSetting(
                            shutter: baseShutter,
                            aperture: n,
                            iso: Int(round(max(100, iso)))
                        )
                    )
                }
            } else {
                let t = baseShutter / pow(2.0, Double(evShift))
                if t < body.slowestShutterSpeed || t > body.fastestShutterSpeed { continue }
                let iso = calculateISO(evEff: evEff, shutter: t, aperture: baseAperture)
                if iso > 0 && iso <= Double(isoCap) {
                    spectrum.append(
                        ExposureSetting(
                            shutter: t,
                            aperture: baseAperture,
                            iso: Int(round(max(100, iso)))
                        )
                    )
                }
            }
        }
        
        return spectrum
    }
    
    // MARK: - Helpers
    private func clamp(_ value: Double, min: Double, max: Double) -> Double {
        return Swift.max(min, Swift.min(max, value))
    }
}

