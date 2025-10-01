//
//  Intent.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct Intent {
    let place: String        // "indoor" | "outdoor"
    let subject: String      // "stillLife" | "landscape"
    let motion: String       // "stillness" | "dynamic"
    let dof: Bool // 아포 O | 아포 X
}
