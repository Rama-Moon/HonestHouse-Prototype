//
//  CameraItemListView.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import SwiftUI

struct CameraItemListView<Item: Identifiable & Equatable>: View {
    let type: CameraItemSelectionType
    let items: [Item]
    @Binding var selectedItem: Item?
    let label: (Item) -> String
    
    var body: some View {
        List {
            Section(header: Text(type.rawValue)) {
                ForEach(items) { item in
                    Button {
                        selectedItem = item
                    } label: {
                        Text(label(item))
                            .foregroundColor(selectedItem == item ? .hhcolor(.text(.white)) : .hhcolor(.text(.primary)))
                            .font(.body)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground((selectedItem == item ? .hhcolor(.buttonBackground(.primary)) : Color.clear))
                }
            }
        }
        .listStyle(.plain)
    }
}
