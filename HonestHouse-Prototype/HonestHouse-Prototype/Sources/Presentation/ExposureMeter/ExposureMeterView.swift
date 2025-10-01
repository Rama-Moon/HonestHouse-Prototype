//
//  ExposureMeterView.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI

enum CameraMode {
    case AMode
    case SMode
    case MMode
    
    var title: String {
        switch self {
        case .AMode:
            return "AMode"
        case .SMode:
            return "SMode"
        case .MMode:
            return "MMode"
        }
    }
}

struct ExposureMeterView: View {
    @State private var ev: Double = 0
    @State private var mode: String = "A Mode"
    @State private var isStabilized: Bool = false
    @State private var showDetailValue: Bool = false
    
    // 입력된 의도
    let inputIntent: Intent
    
    var body: some View {
        ZStack {
            ExposureMeterRepersentable(
                ev: $ev,
                onStabilized: {
                    isStabilized = true
                },
                onUnstabilized: {
                    isStabilized = false
                }
            )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                exposureValueDisplay()
                    .padding(16)
                
                Spacer()
                
                exposureLockButton()
            }
        }
        .sheet(isPresented: $showDetailValue) {
            Text("EV 안정화됨!")
        }
        .onChange(of: isStabilized) {
            print("\(isStabilized)")
        }
    }
        
    func exposureValueDisplay() -> some View {
        VStack(spacing: 18) {
            Text("\(mode)")
                .font(.title)
                .foregroundStyle(.black)
            
            HStack() {
                Text("F:")
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
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func exposureLockButton() -> some View {
        Button(action: {
            showDetailValue = true
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 72, height: 72)
                
                Image(systemName: isStabilized ? "lock.open.fill" : "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(isStabilized ? .green : .black)
            }
        }
        .disabled(!isStabilized)
    }
}
