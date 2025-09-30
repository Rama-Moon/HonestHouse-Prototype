//
//  CaseSelectViewModel.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI

@Observable
class CaseSelectViewModel {
    var selectedPlace: Place? = nil
    var selectedSubject: Subject? = nil
    var selectedMovement: Movements? = nil
    var selectedDOF: DOF? = nil

    var allSelectionsMade: Bool {
        guard selectedPlace != nil,
              selectedSubject != nil
        else {
            return false
        }

        if selectedSubject == .scenery {
            return true
        } else {
            return selectedMovement != nil && selectedDOF != nil
        }
    }

    func resetAfterSubjectChange() {
        selectedMovement = nil
        selectedDOF = nil
    }
}

