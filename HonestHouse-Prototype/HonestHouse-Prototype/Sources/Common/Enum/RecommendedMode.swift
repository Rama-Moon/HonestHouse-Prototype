//
//  RecommendedMode.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

enum RecommendedMode: String {
    case manual = "M"
    case shutterPriority = "S"
    case aperturePriority = "A"
    
    /// 각 추천 모드가 내부적으로 어떤 앵커를 쓰는지 연결
    var anchor: AnchorMode {
        switch self {
        case .manual, .shutterPriority:
            return .shutter
        case .aperturePriority:
            return .aperture
        }
    }
}
