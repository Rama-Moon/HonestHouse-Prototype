//
//  CameraLensSelectionView.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import SwiftUI

struct CameraLensSelectionView: View {
    let manufacturer: Manufacturer
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
                print("완료 누름")
                // TODO: MeteringView로 이동
            }, isEnabled: selectedLens != nil)
            .padding(.horizontal, 16)
        }
        .navigationTitle(manufacturer.rawValue)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CameraLensSelectionView(manufacturer: .canon)
}
