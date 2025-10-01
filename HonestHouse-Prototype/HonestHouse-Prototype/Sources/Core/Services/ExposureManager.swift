//
//  ExposureManager.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation
import SwiftUI

final class ExposureManager {
    
    // MARK: - 실제 사용 함수
    public func recommendExposure(
        body: CameraBody,
        lens: CameraLens,
        intent: Intent,
        ev100: Double,
        isoCap: Int,
        isNight: Bool,
        isBacklight: Bool,
        evBacklightBias: Double
    ) -> (subtype: ModeSubtype, base: ExposureSetting, spectrum: [ExposureSetting]) {
        
        // 역광일 때, EV 보정
        if isBacklight {
            let evEff = ev100 - evBacklightBias
        } else {
            let evEff = ev100
        }
        
        // 1. 추천 모드 결정
        let subtype = decideModeSubtype(intent: intent, isNight: isNight)
        
        // 2. 모드에 맞는 전략 선택
        let strategy = strategyForSubtype(subtype)
        
        // 3. Base 계산
        var base = strategy.calculateBase(ev100: evEff, lens: lens, body: body)
        
        // ISO 보정 (ISO 100 ~ isoCap 범위로 제한)
        base = applyIsoCorrection(setting: base, ev100: evEff, isoCap: isoCap)
        
        // 스펙트럼 생성
        let spectrum = strategy.generateSpectrum(ev100: evEff, lens: lens, body: body, isoCap: isoCap)
        
        return (subtype, base, spectrum)
    }
    
    // MARK: - 내부 로직 함수
    // 모드에 따른 전략 매핑
    private func strategyForSubtype(_ subtype: ModeSubtype) -> ModeStrategy {
        switch subtype {
        case .M1: return M1Strategy()
        case .M2: return M2Strategy()
        case .A1: return A1Strategy()
        case .A2: return A2Strategy()
        case .A3: return A3Strategy()
        case .S:  return SStrategy()
        }
    }
    
    // 모드 결정
    private func decideModeSubtype(intent: Intent, isNight: Bool) -> ModeSubtype {
        for rule in rules {
            if (rule.place == intent.place || rule.place.isEmpty) &&
               (rule.subject == intent.subject || rule.subject.isEmpty) &&
               (rule.motion == intent.motion || rule.motion.isEmpty) &&
               (rule.dof == nil || rule.dof == intent.dof) &&
               (rule.night == nil || rule.night == isNight) {
                return rule.result
            }
        }
        return .S
    }
    
    // ISO 보정
    private func applyIsoCorrection(setting: ExposureSetting, ev100: Double, isoCap: Int) -> ExposureSetting {
        var iso = isoFor(ev100: ev100, shutter: setting.shutter, aperture: setting.aperture)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }
        return ExposureSetting(shutter: setting.shutter, aperture: setting.aperture, iso: Int(round(iso)))
    }
}

