//
//  ModeStrategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

protocol ModeStrategy {
    var subtype: ModeSubtype { get }
    func calculateBase(ev100: Double, lens: Lens, body: Body) -> ExposureSetting
    func generateSpectrum(ev100: Double, lens: Lens, body: Body, isoCap: Int) -> [ExposureSetting]
}

