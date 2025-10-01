//
//  ExposureManager.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation
import SwiftUI

final class ExposureManager {
    
    func recommendExposure(
        body: CameraBody,
        lens: CameraLens,
        intent: Intent,
        ev100: Double,           // 아이폰 측광 EV(ISO100 기준으로 변환된 값 권장)
        isoCap: Int,             // 허용 상한(예: 3200/6400/12800)
        isNight: Bool,           // 야외-풍경 밤 분기용
        evBacklightBias: Double  // 역광 보정(양수면 밝게 보정 필요 → 유효 EV 낮아짐)
    ) -> (subtype: ModeSubtype, base: ExposureSetting, spectrum: [ExposureSetting]) {
        
        // EV 유효값 (역광 보정 적용)
        let evEff = ev100 - evBacklightBias
        
        // 1) 추천모드 결정 (의도 → 세부 서브타입)
        let subtype = decideModeSubtype(intent: intent, isNight: isNight)
        
        // 2) 앵커 매핑 (내부 계산용)
        let _ = subtype.anchor // 필요 시 분기 사용
        
        // 3) Base 계산 (EV/핸드헬드/바디·렌즈 한계 반영)
        var base = calculateBase(subtype: subtype, ev100: evEff, lens: lens, body: body)
        
        // 4) ISO 보정 (100~ISO_cap로 클램프)
        base = applyIsoCorrection(setting: base, ev100: evEff, isoCap: isoCap)
        
        // 5) 권장 범위 스펙트럼 생성 (의도별 범위를 범위샘플링)
        let spectrum = generateSpectrumForSubtype(
            subtype: subtype,
            ev100: evEff,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
        
        return (subtype, base, spectrum)
    }
    
    // MARK: 1) 추천 모드 결정
    
    func decideModeSubtype(intent: Intent, isNight: Bool) -> ModeSubtype {
        if intent.place == "indoor" && intent.subject == "landscape" {
            return .A1
        } else if intent.place == "indoor" && intent.subject == "people" && intent.motion == "dynamic" && intent.wantsBokeh {
            return .M1
        } else if intent.place == "indoor" && intent.subject == "people" && intent.motion == "dynamic" && !intent.wantsBokeh {
            return .S
        } else if intent.place == "indoor" && intent.subject == "people" && intent.motion == "static" && intent.wantsBokeh {
            return .A2
        } else if intent.place == "indoor" && intent.subject == "people" && intent.motion == "static" && !intent.wantsBokeh {
            return .A3
        } else if intent.place == "outdoor" && intent.subject == "landscape" {
            return isNight ? .M2 : .A3
        } else if intent.place == "outdoor" && intent.subject == "people" && intent.motion == "dynamic" && intent.wantsBokeh {
            return .M1
        } else if intent.place == "outdoor" && intent.subject == "people" && intent.motion == "dynamic" && !intent.wantsBokeh {
            return .S
        } else if intent.place == "outdoor" && intent.subject == "people" && intent.motion == "static" && intent.wantsBokeh {
            return .A2
        } else if intent.place == "outdoor" && intent.subject == "people" && intent.motion == "static" && !intent.wantsBokeh {
            return .A3
        }
        return .S
    }
    
    // MARK: 3) Base 계산 (EV 기반 유연식)
    //  - A모드(앵커=aperture): EV로 계산된 t_ref와 핸드헬드 한계 t_hand 중 "더 빠른(작은) 쪽"을 채택
    //    -> t = min(t_ref, t_hand). 만약 t_ref가 너무 느리면 t를 t_hand로 끊고 ISO를 올림.
    //  - S/M(앵커=shutter): 의도 셔터를 고정하고 조리개/ISO에서 해결
    func calculateBase(subtype: ModeSubtype, ev100: Double, lens: Lens, body: Body) -> ExposureSetting {
        let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
        
        var tBase: Double = 1/125.0
        var nBase: Double = 2.8
        var iso: Double = 100
        
        switch subtype {
        case .M1:
            // 동적+보케: 빠른 셔터 + 최대개방
            tBase = clamp(1.0/500.0, min: body.shutterMax, max: body.shutterMin) // 주의: shutterMax가 더 작음(예: 1/8000)
            nBase = lens.N_min
            iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
            
        case .M2:
            // 야경(삼각대 변수 없음): 느린 셔터 + 가능한 개방(손각대 성공률 ↑)
            tBase = clamp(2.0, min: body.shutterMax, max: body.shutterMin)
            nBase = max(2.0, lens.N_min) // f/2.0 이상 확보, 렌즈에 따라 f/2.8 등
            iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
            
        case .A1:
            // 실내 풍경: f/8~11 권장 → base는 f/8, t=min(t_ref, tHand)
            nBase = clamp(8.0, min: lens.N_min, max: lens.N_max)
            let tRef = (nBase * nBase) / pow(2.0, ev100)
            tBase = min(tRef, tHand)
            tBase = clamp(tBase, min: body.shutterMax, max: body.shutterMin)
            iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
            
        case .A2:
            // 정적 인물 + 보케: f/2.8 이상 개방, t=min(t_ref, tHand)
            nBase = max(lens.N_min, 2.8)
            let tRef = (nBase * nBase) / pow(2.0, ev100)
            tBase = min(tRef, tHand)
            tBase = clamp(tBase, min: body.shutterMax, max: body.shutterMin)
            iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
            
        case .A3:
            // 일반 인물/야외 풍경: f/8, t=min(t_ref, tHand)
            nBase = clamp(8.0, min: lens.N_min, max: lens.N_max)
            let tRef = (nBase * nBase) / pow(2.0, ev100)
            tBase = min(tRef, tHand)
            tBase = clamp(tBase, min: body.shutterMax, max: body.shutterMin)
            iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
            
        case .S:
            // 동적 인물(보케X): 빠른 셔터 + 조리개는 f/8 근처로 심도 확보
            tBase = clamp(1.0/500.0, min: body.shutterMax, max: body.shutterMin)
            nBase = clamp(8.0, min: lens.N_min, max: lens.N_max)
            iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        }
        
        if iso < 100 { iso = 100 }
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(round(iso)))
    }
    
    // MARK: 4) ISO 보정 (Cap 반영)
    func applyIsoCorrection(setting: ExposureSetting, ev100: Double, isoCap: Int) -> ExposureSetting {
        var iso = isoFor(ev100: ev100, shutter: setting.shutter, aperture: setting.aperture)
        if iso < 100 { iso = 100 }
        if iso > Double(isoCap) { iso = Double(isoCap) }
        return ExposureSetting(shutter: setting.shutter, aperture: setting.aperture, iso: Int(round(iso)))
    }
    
    // MARK: 5) 권장 범위 스펙트럼 (의도별 범위를 직접 샘플링)
    func generateSpectrumForSubtype(
        subtype: ModeSubtype,
        ev100: Double,
        lens: Lens,
        body: Body,
        isoCap: Int
    ) -> [ExposureSetting] {
        switch subtype {
        case .A1:
            // 풍경: f/8~11
            return generateApertureSpectrum(
                apertureRange: 8.0...11.0,
                stepThirdStops: 1,   // 1/3스톱 단위
                ev100: ev100,
                lens: lens,
                body: body,
                isoCap: isoCap
            )
            
        case .A2:
            // 인물 보케: f/2.8~5.6 (렌즈 한계로 클램프)
            let lo = max(lens.N_min, 2.8)
            let hi = min(lens.N_max, 5.6)
            guard lo <= hi else { return [] }
            return generateApertureSpectrum(
                apertureRange: lo...hi,
                stepThirdStops: 1,
                ev100: ev100,
                lens: lens,
                body: body,
                isoCap: isoCap
            )
            
        case .A3:
            // 일반 인물/야외 풍경: f/8~11
            return generateApertureSpectrum(
                apertureRange: 8.0...11.0,
                stepThirdStops: 1,
                ev100: ev100,
                lens: lens,
                body: body,
                isoCap: isoCap
            )
            
        case .S:
            // 동적 인물, 보케X: 1/1000~1/500 (초 단위로 0.001~0.002), 조리개는 f/8 고정
            return generateShutterSpectrum(
                shutterRange: (1.0/1000.0)...(1.0/500.0),
                aperture: clamp(8.0, min: lens.N_min, max: lens.N_max),
                stepThirdStops: 1,
                ev100: ev100,
                body: body,
                isoCap: isoCap
            )
            
        case .M1:
            // 동적+보케: 1/1000~1/500, 조리개는 최대개방 고정
            return generateShutterSpectrum(
                shutterRange: (1.0/1000.0)...(1.0/500.0),
                aperture: lens.N_min,
                stepThirdStops: 1,
                ev100: ev100,
                body: body,
                isoCap: isoCap
            )
            
        case .M2:
            // 야경(삼각대 변수 없음): 2~15초, 가능한 개방 (손각대 성공률 고려)
            return generateShutterSpectrum(
                shutterRange: 2.0...15.0,
                aperture: max(2.0, lens.N_min),
                stepThirdStops: 1,
                ev100: ev100,
                body: body,
                isoCap: isoCap
            )
        }
    }
    
    // MARK: - Spectrum Helpers
    
    // 조리개 범위를 일정 스텝(1/3스톱)으로 훑으면서, 각 점에서 t와 ISO를 EV식으로 재산출
    // A모드 계열에서는 핸드헬드 한계를 고려해 t = min(t_ref, t_hand)로 "더 빠르게" 끊고 ISO로 보상
    private func generateApertureSpectrum(
        apertureRange: ClosedRange<Double>,
        stepThirdStops: Int,
        ev100: Double,
        lens: Lens,
        body: Body,
        isoCap: Int
    ) -> [ExposureSetting] {
        var out: [ExposureSetting] = []
        
        let stepFactor = pow(kApertureThirdStopFactor, Double(stepThirdStops)) // 1/3스톱 * N
        var f = apertureRange.lowerBound
        
        let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
        
        while f <= apertureRange.upperBound + 1e-9 {
            // t_ref (ISO100) 계산
            let tRef = (f * f) / pow(2.0, ev100)
            // 핸드헬드 고려: 더 빠른 쪽(작은 값) 선택 → 느려지지 않도록
            var t = min(tRef, tHand)
            t = clamp(t, min: body.shutterMax, max: body.shutterMin)
            
            // ISO 계산 및 클램프
            var iso = isoFor(ev100: ev100, shutter: t, aperture: f)
            if iso < 100 { iso = 100 }
            if iso > Double(isoCap) { iso = Double(isoCap) }
            
            out.append(ExposureSetting(shutter: t, aperture: f, iso: Int(round(iso))))
            
            f *= stepFactor
        }
        
        return out
    }
    
    // 셔터 범위를 일정 스텝(1/3스톱)으로 훑으면서, 각 점에서 ISO를 EV식으로 재산출
    // S/M 계열은 셔터 고정 성격이므로 조리개는 고정값으로 입력
    private func generateShutterSpectrum(
        shutterRange: ClosedRange<Double>,
        aperture: Double,
        stepThirdStops: Int,
        ev100: Double,
        body: Body,
        isoCap: Int
    ) -> [ExposureSetting] {
        var out: [ExposureSetting] = []
        
        let stepFactor = pow(kShutterThirdStopFactor, Double(stepThirdStops)) // 1/3스톱 * N
        var t = shutterRange.lowerBound
        
        while t <= shutterRange.upperBound + 1e-12 {
            var tClamped = clamp(t, min: body.shutterMax, max: body.shutterMin)
            
            // ISO 계산 및 클램프
            var iso = isoFor(ev100: ev100, shutter: tClamped, aperture: aperture)
            if iso < 100 { iso = 100 }
            if iso > Double(isoCap) { iso = Double(isoCap) }
            
            out.append(ExposureSetting(shutter: tClamped, aperture: aperture, iso: Int(round(iso))))
            
            t *= stepFactor
        }
        
        return out
    }
}

