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
    @Binding var baseExposure: ExposureSetting?
    @Binding var spectrum: [ExposureSetting]
    @Binding var response: String
    @Binding var showDetailValue: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            
            VStack(spacing: 18) {
                VStack(spacing: 18) {
                    HStack {
                        Text("\(mode)")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            showDetailValue = false
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.black)
                        }
                    }
                    
                    HStack() {
                        if let first = spectrum.first,
                           let last = spectrum.last {
                            Text("F:")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("\(first.aperture, specifier: "%.1f")")
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.hhcolor(color: .buttonBackground(.disabled)))
                                )
                            
                            if mode == "A Mode" || mode == "M Mode" {
                                Group {
                                    Text("-")
                                    Text("\(last.aperture, specifier: "%.1f")")
                                }
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.hhcolor(color: .buttonBackground(.disabled)))
                                )
                            }
                            
                            Spacer()
                        }
                    }
                    
                    if let first = spectrum.first,
                       let last = spectrum.last {
                        HStack {
                            Text("S:")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text(String(formatShutterSpeed(first.shutter)))
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.hhcolor(color: .buttonBackground(.disabled)))
                                )
                            
                            if mode == "S Mode" || mode == "M Mode" {
                                Group {
                                    Text("-")
                                    Text(String(formatShutterSpeed(last.shutter)))
                                }
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.hhcolor(color: .buttonBackground(.disabled)))
                                )
                            }
                            
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("ISO:")
                            .font(.system(size: 20, weight: .semibold))
                        if let baseExposure = baseExposure {
                            Text("\(baseExposure.iso)")
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.hhcolor(color: .buttonBackground(.disabled)))
                                )
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text("EV:")
                            .font(.system(size: 20, weight: .semibold))
                        Text("\(ev, specifier: "%.2f")")
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.hhcolor(color: .buttonBackground(.disabled)))
                            )
                        Spacer()
                    }
                }
                
                VStack(alignment:.leading, spacing: 6) {
                    Text("Why This Setting")
                        .font(.system(size: 16, weight: .semibold))
                    Text("\(response)")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .lineLimit(nil)
                }
            }
            .padding(22)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 16)
        }
    }
}

func formatShutterSpeed(_ shutter: Double) -> String {
    if shutter >= 1 {
        return "\(Int(shutter))\""
    } else {
        return "1/\(Int(round(1/shutter)))"
    }
}
