//
//  CameraManufacturerView.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI

struct CameraManufacturerView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isOnboarding: Bool
    
    @AppStorage("cameraManufacturer") private var selectedManufacturer: String = ""
    @State private var path: [OnboardingRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                cameraButton(.sony)
                Divider()
                cameraButton(.canon)
                Divider()
                cameraButton(.nikon)
            }
            .navigationDestination(for: OnboardingRoute.self) { route in
                switch route {
                case .cameraBody(let m):
                    CameraBodySelectionView(manufacturer: m, path: $path, modelContext: modelContext)
                case .cameraLens(let m):
                    CameraLensSelectionView(manufacturer: m, isOnboarding: $isOnboarding, modelContext: modelContext)
                }
            }
        }
    }
    
    func cameraButton(_ manufacturer: Manufacturer) -> some View {
        Button {
            selectedManufacturer = manufacturer.rawValue
            path.append(.cameraBody(manufacturer))
        } label: {
            Text(manufacturer.rawValue)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color.white)
        }
    }
}
