//
//  CameraManufacturerView.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI

struct CameraManufacturerView: View {
    @Binding var isOnboarding: Bool
    
    @AppStorage("cameraManufacturer") private var selectedManufacturer: String = ""
    @State private var path: [OnboardingRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                cameraButton(title: "SONY")
                Divider()
                cameraButton(title: "Canon")
                Divider()
                cameraButton(title: "Nikon")
            }
            .navigationDestination(for: OnboardingRoute.self) { route in
                switch route {
                case .cameraBody(let m):
                    CameraBodySelectionView(manufacturer: m, path: $path)
                case .cameraLens(let m):
                    CameraLensSelectionView(manufacturer: m, isOnboarding: $isOnboarding)
                }
            }
        }
    }
    
    func cameraButton(title: String) -> some View {
        Button(action: {
            selectedManufacturer = title
            path.append(title)
        }) {
            Text(title)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color.white)
        }
    }
}

struct NextView: View {
    let brand: String
    
    var body: some View {
        Text("\(brand) 선택됨")
            .navigationTitle(brand)
    }
}

#Preview {
    CameraManufacturerView()
}
