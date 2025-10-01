//
//  ExposureDetailView.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

import SwiftUI

struct ExposureDetailView: View {
    @Binding var ev: Double
    @Binding var mode: String
    @Binding var response: String
    @Binding var showDetailValue: Bool
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            VStack(spacing: 18) {
                VStack(spacing: 18) {
                    HStack {
                        Text("\(mode)")
                            .font(.title)
                         
                        Spacer()
                        
                        Button {
                            showDetailValue = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.white)
                        }
                    }
                    
                    HStack() {
                        Text("F:")
                        Text("5.6").valueChipStyle()
                        Text("-").valueChipStyle()
                        Text("5.6").valueChipStyle()
                        Spacer()
                    }
                    
                    HStack {
                        Text("S:")
                        Text("1/100").valueChipStyle()
                        Spacer()
                    }
                    
                    HStack {
                        Text("ISO:")
                        Text("100").valueChipStyle()
                        Spacer()
                    }
                    
                    HStack {
                        Text("EV:")
                        Text("\(ev, specifier: "%.2f")").valueChipStyle()
                        Spacer()
                    }
                }
                
                VStack(spacing: 6) {
                    Text("Why This Setting")
                    Text("\(response)")
                        .lineLimit(nil)
                }
            }
            .padding(22)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
