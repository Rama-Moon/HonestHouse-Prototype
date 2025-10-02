//
//  ExposureMeterView.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI
import SwiftData

struct ExposureMeterView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var ev: Double = 0
    @State private var mode: String = "A Mode"
    @State private var isStabilized: Bool = false
    @State private var showDetailValue: Bool = false
    
    @State private var response = ""
    @State private var isLoading = false
    @State private var isBacklit = false
    
    @State private var recommendedMode: CameraMode = .MMode
    @State private var baseExposure: ExposureSetting?
    @State private var exposureSpectrum: [ExposureSetting] = []
    
    @Query private var savedBodies: [CameraBody]
    @Query private var savedLenses: [CameraLens]
    
    var apertureDisplay: String {
        if recommendedMode == .SMode {
            return "Auto"
        }
        return String(format: "%.2f", baseExposure?.aperture ?? 0.0)
    }
    
    var shutterDisplay: String {
        if recommendedMode == .AMode {
            return "Auto"
        }
        return String(formatShutterSpeed(baseExposure?.shutter ?? 0.01))
    }
    
    let inputIntent: Intent
    
    var body: some View {
        ZStack {
            ExposureMeterRepresentable(
                ev: $ev,
                onStabilized: {
                    isStabilized = true
                },
                onUnstabilized: {
                    isStabilized = false
                },
                isPaused: $showDetailValue
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                if !showDetailValue {
                    exposureValueDisplay()
                        .padding(16)
                }
                
                Spacer()
                
                ZStack(alignment: .center) {
                    SolarRotationView(isBacklit: $isBacklit)
                    exposureLockButton()
                    if !showDetailValue {
                        HStack {
                            exitButton()
                                .padding(.leading, 40)
                            Spacer()
                        }
                    }
                }
                .safeAreaPadding(.bottom, 10)
            }
        }
        .overlay {
            if showDetailValue {
                ExposureDetailView(
                    ev: $ev,
                    mode: $mode,
                    baseExposure: $baseExposure,
                    spectrum: $exposureSpectrum,
                    response: $response,
                    showDetailValue: $showDetailValue
                )
                .ignoresSafeArea()
            }
        }
        .onAppear {
            updateExposureSettings()
        }
        .onChange(of: ev) { oldValue, newValue in
            updateExposureSettings()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func updateExposureSettings() {
        guard let body = savedBodies.first,
              let lens = savedLenses.first else {
            return
        }
        
        let result = ExposureManager.recommendExposure(
            body: body,
            lens: lens,
            intent: inputIntent,
            ev100: ev,
            isoCap: 20000,
            isNight: false,
            isBacklight: isBacklit
        )
        
        recommendedMode = result.recomMode
        baseExposure = result.base
        exposureSpectrum = result.spectrum
        mode = result.recomMode.title
    }
    
    func formatShutterSpeed(_ shutter: Double) -> String {
        if shutter >= 1 {
            return "\(Int(shutter))\""
        } else {
            return "1/\(Int(round(1/shutter)))"
        }
    }
    
    func exposureValueDisplay() -> some View {
        VStack(spacing: 18) {
            HStack {
                Text("\(mode)")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.black)
                Spacer()
                HStack(spacing: 16) {
                    Text("EV:")
                        .font(.system(size: 20, weight: .semibold))
                    Text("\(ev, specifier: "%.2f")")
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.5))
                        )
                }
            }
            
            HStack() {
                Text("F:")
                    .font(.system(size: 20, weight: .semibold))
                
                Text(apertureDisplay)
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill([.AMode, .MMode].contains(recommendedMode) ? Color.white : Color.white.opacity(0.5))
                    )
                
                Spacer()
                
                Text("S:")
                    .font(.system(size: 20, weight: .semibold))
                
                Text(shutterDisplay)
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill([.SMode, .MMode].contains(recommendedMode) ? Color.white : Color.white.opacity(0.5))
                    )
                
                Spacer()
                
                Text("ISO:")
                    .font(.system(size: 20, weight: .semibold))
                
                Text("\(baseExposure?.iso ?? 0)")
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white)
                    )
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func exitButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(.exitButton)
        }
    }
    
    func exposureLockButton() -> some View {
        Button(action: {
            Task {
                //                await sendRequest()
                getDescription(for: inputIntent)
                showDetailValue = true
            }
        }) {
            ZStack {
                if showDetailValue {
                    Image(.locked)
                } else {
                    Image(isStabilized ? .unlocked : .locked)
                }
            }
        }
        .disabled(!isStabilized)
    }
    
    private func sendRequest() async {
        isLoading = true
        
        let userInput =
        """
        Hello, GPT
        """
        
        Task {
            do {
                var messages = PromptManager.createPhotographyAssistant(
                    A: 8.0,
                    SS: 1/125,
                    ISO: 100
                )
                messages.append(ChatMessage(role: "user", content: userInput))
                let result = try await OpenAIService().sendMessage(messages: messages)
                response = result
            } catch {
                response = "Error: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    func getDescription(for intent: Intent) {
        response = Guiding.from(intent)?.description ?? ""
    }
}
