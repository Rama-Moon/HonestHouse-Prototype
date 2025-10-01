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
    var intent = Intent()
    
    var allSelectionsMade: Bool {
        intent.allSelectionsMade
    }
    
    func resetAfterSubjectChange() {
        intent.resetAfterSubjectChange()
    }
}

