//
//  RootView.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import SwiftUI

struct RootView: View {
    @AppStorage("isOnboarding") private var isOnboarding: Bool = true
    
    var body: some View {
        if isOnboarding {
            CameraManufacturerView(isOnboarding: $isOnboarding)
        } else {
            CaseSelectView()
        }
    }
}

#Preview {
    RootView()
}
