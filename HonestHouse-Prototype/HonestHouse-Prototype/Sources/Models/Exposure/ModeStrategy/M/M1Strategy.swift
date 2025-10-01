//
//  M1Strategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct M1Strategy: ModeStrategy {
    let subtype: ModeSubtype = .M1

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        let tBase = clamp(1.0/500.0, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        let nBase = lens.maxOpenAperture
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: (1.0/1000.0)...(1.0/500.0),
            aperture: lens.maxOpenAperture,
            stepThirdStops: 1,
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}

