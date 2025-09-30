//
//  ExposureMeterRepersentable.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI

struct ExposureMeterRepersentable: UIViewRepresentable {
    @Binding var iso: Float
    @Binding var exposureDuration: Double
    @Binding var aperture: Float
    @Binding var ev: Double
    @Binding var bias: Float
    @Binding var offset: Float

    func makeUIView(context: Context) -> ExposureMeterUIView {
        let view = ExposureMeterUIView()

        view.onExposureValueUpdate = { value in
            DispatchQueue.main.async {
                self.iso = value.iso
                self.exposureDuration = value.exposureDuration
                self.aperture = value.aperture
                self.ev = value.ev
                self.bias = value.bias
                self.offset = value.offset
            }
        }
        return view
    }

    func updateUIView(_ uiView: ExposureMeterUIView, context: Context) {}
}

