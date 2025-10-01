//
//  SStrategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct SStrategy: ModeStrategy {
    let subtype: ModeSubtype = .S

    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting {
        let tBase = clamp(1.0/500.0, min: body.fastestShutterSpeed, max: body.slowestShutterSpeed)
        let nBase = clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture)
        let iso = isoFor(ev100: ev100, shutter: tBase, aperture: nBase)
        return ExposureSetting(shutter: tBase, aperture: nBase, iso: Int(max(100, round(iso))))
    }

    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting] {
        return generateShutterSpectrum(
            shutterRange: (1.0/1000.0)...(1.0/500.0),
            aperture: clamp(8.0, min: lens.maxOpenAperture, max: lens.minOpenAperture),
            stepThirdStops: 1,
            ev100: ev100,
            body: body,
            isoCap: isoCap
        )
    }
}


