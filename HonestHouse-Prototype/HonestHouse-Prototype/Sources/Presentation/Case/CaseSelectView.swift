//
//  CaseSelectView.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import SwiftUI

struct CaseSelectView: View {
    @Bindable var viewModel: CaseSelectViewModel = .init()
    @State private var goToMetering: Bool = false
    
    var body: some View {
        NavigationStack {
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
                    goToMetering = true
                }, isEnabled: viewModel.allSelectionsMade)
            }
            .padding()
            .navigationDestination(isPresented: $goToMetering, destination: {
                ExposureMeterView()
            })
            .navigationTitle("Case")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    @ViewBuilder
    func renderRadioSection(for section: Case) -> some View {
        switch section {
        case .place:
            RadioButtonGroup(title: section.rawValue, options: Place.allCases, isEnabled: true, selected: $viewModel.selectedPlace)
            
        case .subject:
            RadioButtonGroup(title: section.rawValue, options: Subject.allCases, isEnabled: true, selected: $viewModel.selectedSubject)
                .onChange(of: viewModel.selectedSubject) { _, _ in
                    viewModel.selectedMovement = nil
                    viewModel.selectedDOF = nil
                }
            
        case .movements:
            RadioButtonGroup(title: section.rawValue, options: Movements.allCases, isEnabled: viewModel.selectedSubject != .scenery, selected: $viewModel.selectedMovement)
            
        case .dof:
            RadioButtonGroup(title: section.rawValue, options: DOF.allCases, isEnabled: viewModel.selectedSubject != .scenery, selected: $viewModel.selectedDOF)
        }
    }
}
