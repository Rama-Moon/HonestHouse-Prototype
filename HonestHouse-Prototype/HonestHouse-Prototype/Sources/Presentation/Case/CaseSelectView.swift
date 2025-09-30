//
//  CaseSelectView.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import SwiftUI

struct CaseSelectView: View {
    // 선택된 의도들
    @State private var selectedPlace: Place? = nil
    @State private var selectedSubject: Subject? = nil
    @State private var selectedMovement: Movements? = nil
    @State private var selectedDOF: DOF? = nil
    
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
    
    var body: some View {
        VStack(alignment: .leading) {
            RadioButtonGroup(title: "장소", options: Place.allCases, isEnabled: true, selected: $selectedPlace)
            
            Spacer()
            Divider()
            Spacer()

            RadioButtonGroup(title: "피사체", options: Subject.allCases, isEnabled: true, selected: $selectedSubject)
                .onChange(of: selectedSubject) { _, _ in
                    selectedMovement = nil
                    selectedDOF = nil
                }
            
            Spacer()
            Divider()
            Spacer()
            
            RadioButtonGroup(
                title: "움직임",
                options: Movements.allCases,
                isEnabled: selectedSubject != .scenery,
                selected: $selectedMovement
            )
            
            Spacer()
            Divider()
            Spacer()

            RadioButtonGroup(
                title: "아웃포커싱",
                options: DOF.allCases,
                isEnabled: selectedSubject != .scenery,
                selected: $selectedDOF
            )

            Spacer()

            CustomActiveButton(title: "완료", action: {
                print("완료 클릭")
            }, isEnabled: allSelectionsMade)
        }
        .padding()
    }
}

#Preview {
    CaseSelectView()
}
