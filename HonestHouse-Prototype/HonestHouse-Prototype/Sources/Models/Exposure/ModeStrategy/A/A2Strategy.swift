//
//  A2Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct A2Strategy: ModeStrategy {
    let subtype: ModeSubtype = .A2

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        let nBase = max(lens.maxOpenAperture, 2.8)
        let tRef = (nBase * nBase) / pow(2.0, ev100)
        let tHand = handHoldLimit(focalLength: lens.focalLength, cropFactor: body.cropFactor)
        let tBase = min(tRef, tHand)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        let lo = max(lens.maxOpenAperture, 2.8)
        let hi = min(lens.minOpenAperture, 5.6)
        return generateApertureSpectrum(
            apertureRange: lo...hi,
            stepThirdStops: 1,
            ev100: ev100,
            lens: lens,
            body: body,
            isoCap: isoCap
        )
    }
}

