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
            ForEach(Array(Case.allCases.enumerated()), id: \.element) { index, section in
                
                renderRadioSection(for: section)
                
                if index < Case.allCases.count - 1 {
                    Spacer()
                    Divider()
                    Spacer()
                }
            }
            
            Spacer()
            
            CustomActiveButton(title: "완료", action: {
                print("완료 클릭")
            }, isEnabled: allSelectionsMade)
        }
        .padding()
        .navigationTitle("Case")
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    func renderRadioSection(for section: Case) -> some View {
        switch section {
        case .place:
            RadioButtonGroup(title: section.rawValue, options: Place.allCases, isEnabled: true, selected: $selectedPlace)
            
        case .subject:
            RadioButtonGroup(title: section.rawValue, options: Subject.allCases, isEnabled: true, selected: $selectedSubject)
                .onChange(of: selectedSubject) { _, _ in
                    selectedMovement = nil
                    selectedDOF = nil
                }
            
        case .movements:
            RadioButtonGroup(title: section.rawValue, options: Movements.allCases, isEnabled: selectedSubject != .scenery, selected: $selectedMovement)
            
        case .dof:
            RadioButtonGroup(title: section.rawValue, options: DOF.allCases, isEnabled: selectedSubject != .scenery, selected: $selectedDOF)
        }
    }
}

#Preview {
    CaseSelectView()
}
