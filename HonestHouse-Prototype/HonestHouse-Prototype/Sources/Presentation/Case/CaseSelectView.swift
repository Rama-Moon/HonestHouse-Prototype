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
    
    var shouldShowDOF: Bool {
        guard let subject = selectedSubject else { return false }
        if subject == .scenery {
            return true
        } else {
            return selectedMovement != nil
        }
    }
    
    var allSelectionsMade: Bool {
        guard selectedPlace != nil,
              selectedSubject != nil,
              selectedDOF != nil else {
            return false
        }

        if selectedSubject == .scenery {
            return true
        } else {
            return selectedMovement != nil
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            RadioButtonGroup(title: "장소", options: Place.allCases, selected: $selectedPlace)
            
            if selectedPlace != nil {
                Divider()
                
                RadioButtonGroup(title: "피사체", options: Subject.allCases, selected: $selectedSubject)
                    .onChange(of: selectedSubject) { oldValue, newValue in
                        // subject 바뀔 때마다 관련 선택값 초기화
                        selectedMovement = nil
                        selectedDOF = nil
                    }
            }
            
            // "풍경" 선택 X, 움직임 Case로 넘어감
            if let subject = selectedSubject, subject != .scenery {
                Divider()
                
                RadioButtonGroup(title: "움직임", options: Movements.allCases, selected: $selectedMovement)
            }
            
            if shouldShowDOF {
                Divider()
                
                RadioButtonGroup(title: "심도", options: DOF.allCases, selected: $selectedDOF)
            }
            
            Spacer()
            
            CustomActiveButton(title: "완료", action: { print("클릭") }, isEnabled: allSelectionsMade)
        }
        .padding()
    }
}

#Preview {
    CaseSelectView()
}
