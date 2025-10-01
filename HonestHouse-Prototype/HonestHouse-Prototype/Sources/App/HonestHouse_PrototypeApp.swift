//
//  HonestHouse_PrototypeApp.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/29/25.
//

import SwiftUI
import SwiftData

@main
struct HonestHouse_PrototypeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [CameraBody.self, CameraLens.self])
    }
}
