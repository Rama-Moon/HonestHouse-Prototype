//
//  ModeStrategy.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation
import SwiftUI

protocol ModeStrategy {
    var subtype: ModeSubtype { get }
    func calculateBase(ev100: Double, lens: CameraLens, body: CameraBody) -> ExposureSetting
    func generateSpectrum(ev100: Double, lens: CameraLens, body: CameraBody, isoCap: Int) -> [ExposureSetting]
}

