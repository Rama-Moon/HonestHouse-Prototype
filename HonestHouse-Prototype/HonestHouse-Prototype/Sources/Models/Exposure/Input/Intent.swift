//
//  Intent.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct Intent: Hashable {
    var place: Place? = nil
    var subject: Subject? = nil
    var movement: Movements? = nil
    var dof: DOF? = nil

    var allSelectionsMade: Bool {
        guard let subject = subject, let place = place else {
            return false
        }

        // 풍경이면 movement/dof 필요 없음
        if subject == .scenery {
            return true
        } else {
            return movement != nil && dof != nil
        }
    }

    /// subject 변경 시 movement, dof 초기화
    mutating func resetAfterSubjectChange() {
        movement = nil
        dof = nil
    }
}

