//
//  CameraLensSelectionView.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import SwiftUI

struct CameraLensSelectionView: View {
    let manufacturer: Manufacturer
    @Binding var isOnboarding: Bool
    
    @State private var selectedLens: CameraLens? = nil
    
    var body: some View {
        VStack(spacing: 5) {
            CameraItemListView(
                type: .lens,
                items: manufacturer.lenses,
                selectedItem: $selectedLens,
                label: { $0.name }
            )
            CustomActiveButton(title: "완료", action: {
                isOnboarding = false
            }, isEnabled: selectedLens != nil)
            .padding(.horizontal, 16)
        }
        .navigationTitle(manufacturer.rawValue)
        .navigationBarTitleDisplayMode(.large)
    }
}
