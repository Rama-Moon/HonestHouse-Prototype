//
//  ExposureMeterRepresentable.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI

struct ExposureMeterRepresentable: UIViewRepresentable {
    @Binding var ev: Double
    var onStabilized: () -> Void
    var onUnstabilized: () -> Void

    func makeUIView(context: Context) -> ExposureMeterUIView {
        let view = ExposureMeterUIView()

        view.onExposureValueUpdate = { value in
            DispatchQueue.main.async {
                self.ev = value.ev
            }
        }
        
        view.onStabilized = {
            DispatchQueue.main.async {
                self.onStabilized()
            }
        }
        
        view.onUnstabilized = {
            DispatchQueue.main.async {
                self.onUnstabilized()
            }
        }
        
        return view
    }

    func updateUIView(_ uiView: ExposureMeterUIView, context: Context) {}
}
