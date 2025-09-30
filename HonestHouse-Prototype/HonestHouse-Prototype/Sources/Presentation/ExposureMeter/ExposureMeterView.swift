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
    @State private var iso: Float = 0
    @State private var exposureDuration: Double = 0
    @State private var aperture: Float = 0
    @State private var ev: Double = 0
    @State private var bias: Float = 0
    @State private var offset: Float = 0
    @State private var mode: String = "AMode"
    
    var body: some View {
        ZStack {
            ExposureMeterRepersentable(
                iso: $iso,
                exposureDuration: $exposureDuration,
                aperture: $aperture,
                ev: $ev,
                bias: $bias,
                offset: $offset
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                exposureValueDisplay()
                    
                    .padding(16)
                
                Spacer()
            }
            
        }
    }
    
    func exposureValueDisplay() -> some View {
        VStack(spacing: 18) {
            Text("\(mode)")
                .font(.title)
                .foregroundStyle(.black)
            
            HStack {
                Text("F:")
                Text("5.6").valueChipStyle()
            }
            
            HStack {
                Text("S:")
                Text("1/100").valueChipStyle()
            }
            
            HStack {
                Text("ISO:")
                Text("100").valueChipStyle()
            }
            
            HStack {
                Text("EV:")
                Text("8.5").valueChipStyle()
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ExposureMeterView()
}
