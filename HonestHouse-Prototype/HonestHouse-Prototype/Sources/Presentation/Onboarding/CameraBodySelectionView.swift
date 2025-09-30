//
//  CameraBodySelectionView.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import SwiftUI

struct CameraBodySelectionView: View {
    let manufacturer: Manufacturer
    @State private var selectedBody: CameraBody? = nil
    
    var body: some View {
        VStack(spacing: 5) {
            CameraItemListView(
                type: .body,
                items: manufacturer.bodies,
                selectedItem: $selectedBody,
                label: { $0.name }
            )
            CustomActiveButton(title: "렌즈 선택하기", action: {
                print("렌즈 선택하기 누름")
                // TODO: LensSelectView로 이동
            }, isEnabled: selectedBody != nil)
            .padding(.horizontal, 16)
        }
        .navigationTitle(manufacturer.rawValue)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CameraBodySelectionView(manufacturer: .canon)
}
