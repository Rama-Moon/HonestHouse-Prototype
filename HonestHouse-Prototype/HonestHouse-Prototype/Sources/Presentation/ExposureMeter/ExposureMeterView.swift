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
    @Environment(\.dismiss) var dismiss
    
    @State private var ev: Double = 0
    @State private var mode: String = "A Mode"
    @State private var isStabilized: Bool = false
    @State private var showDetailValue: Bool = false
    
    @State private var response = ""
    @State private var isLoading = false
    @State private var isBacklit = false
    
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
                    response: $response,
                    showDetailValue: $showDetailValue
                )
                .padding(16)
            }
        }
        .navigationBarBackButtonHidden(true)
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
                await sendRequest()
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
        현재 Exposure Value인 \(ev)값과 조리개, 셔터스피드, ISO 값이 왜 이렇게 설정됐는지 설명
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
}
