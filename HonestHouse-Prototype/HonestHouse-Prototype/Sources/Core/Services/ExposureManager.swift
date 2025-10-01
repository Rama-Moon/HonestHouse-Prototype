//
//  ExposureManager.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation
import SwiftUI

final class ExposureManager {
    
    let rules: [ModeRule] = [
        ModeRule(place: "indoor", subject: "landscape", motion: "", dof: nil, night: nil, result: .A1),
        ModeRule(place: "indoor", subject: "people", motion: "dynamic", dof: true, night: nil, result: .M1),
        ModeRule(place: "indoor", subject: "people", motion: "dynamic", dof: false, night: nil, result: .S),
        ModeRule(place: "indoor", subject: "people", motion: "static", dof: true, night: nil, result: .A2),
        ModeRule(place: "indoor", subject: "people", motion: "static", dof: false, night: nil, result: .A3),
        ModeRule(place: "outdoor", subject: "landscape", motion: "", dof: nil, night: true, result: .M2),
        ModeRule(place: "outdoor", subject: "landscape", motion: "", dof: nil, night: false, result: .A3),
        ModeRule(place: "outdoor", subject: "people", motion: "dynamic", dof: true, night: nil, result: .M1),
        ModeRule(place: "outdoor", subject: "people", motion: "dynamic", dof: false, night: nil, result: .S),
        ModeRule(place: "outdoor", subject: "people", motion: "static", dof: true, night: nil, result: .A2),
        ModeRule(place: "outdoor", subject: "people", motion: "static", dof: false, night: nil, result: .A3),
    ]
    
    func recommendExposure(
        body: CameraBody,
        lens: CameraLens,
        intent: Intent,
        ev100: Double,
        isoCap: Int,
        isNight: Bool,
        evBacklightBias: Double
    ) -> (subtype: ModeSubtype, base: ExposureSetting, spectrum: [ExposureSetting]) {
        
        let evEff = ev100 - evBacklightBias
        let subtype = decideModeSubtype(intent: intent, isNight: isNight)
        let strategy = strategyForSubtype(subtype)
        
        var base = strategy.calculateBase(ev100: evEff, lens: lens, body: body)
        base = applyIsoCorrection(setting: base, ev100: evEff, isoCap: isoCap)
        
        let spectrum = strategy.generateSpectrum(ev100: evEff, lens: lens, body: body, isoCap: isoCap)
        
        return (subtype, base, spectrum)
    }
    
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
    
    func decideModeSubtype(intent: Intent, isNight: Bool) -> ModeSubtype {
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
    
    private func applyIsoCorrection(setting: ExposureSetting, ev100: Double, isoCap: Int) -> ExposureSetting {
        var iso = isoFor(ev100: ev100, shutter: setting.shutter, aperture: setting.aperture)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }
        return ExposureSetting(shutter: setting.shutter, aperture: setting.aperture, iso: Int(round(iso)))
    }
}

