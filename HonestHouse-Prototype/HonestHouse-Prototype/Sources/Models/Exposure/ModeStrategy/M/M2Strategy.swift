//
//  M2Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct M2Strategy: ModeStrategy {
    let subtype: ModeSubtype = .M2

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        let tBase = clamp(2.0, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        let nBase = max(2.0, lens.maxOpenAperture)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: 2.0...15.0,
            aperture: max(2.0, lens.maxOpenAperture),
            stepThirdStops: 1,
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}

