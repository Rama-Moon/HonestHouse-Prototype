//
//  SolarRotationView.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 10/1/25.
//

import SwiftUI
import Combine

struct SolarRotationView: View {
    @ObservedObject private var solar = SolarManager.shared
    @ObservedObject private var heading = HeadingManager.shared
    @StateObject private var locationProvider = LocationProvider()
    
    @State private var relativeBearing: Double = 0.0
    @Binding var isBacklit: Bool
    
    private let refreshInterval: TimeInterval = 600.0
    @State private var timerCancellable: AnyCancellable?
    
    var body: some View {
        ZStack(alignment: .top) {
            // 역광인 경우에만 역광 가이드 이미지가 보이도록
            if isBacklit {
                Image(.backlitGuide)
                    .frame(width: 75)
                    .transition(.opacity)
            }
            ZStack(alignment: .top) {
                Circle().stroke(Color.white.opacity(0.5), lineWidth: 5).frame(width: 107, height: 107)
                // 해가 떠있을 때만 태양 이미지가 보이도록
                if solar.status.isSunUp {
                    Image(.sun)
                        .padding(.top, -25)
                }
            }
            .rotationEffect(.degrees(relativeBearing))
            .animation(.easeInOut(duration: 0.12), value: relativeBearing)
        }
        .onAppear {
            heading.start()
            startTimer()
        }
        .onDisappear {
            heading.stop()
            timerCancellable?.cancel()
            timerCancellable = nil
        }
        .onReceive(locationProvider.$coordinate) { newCoordinate in
            if let coordinate = newCoordinate {
                solar.updateCoordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
                _ = solar.refresh()
                updateRelativeValues()
            }
        }
        .onChange(of: heading.headingInDegrees) {
            updateRelativeValues()
        }
        .onChange(of: solar.azimuth) {
            updateRelativeValues()
        }
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: refreshInterval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                _ = solar.refresh()
                updateRelativeValues()
            }
    }
    
    private func updateRelativeValues() {
        guard let sunAzimuth = solar.azimuth, let sunElevation = solar.elevation else { return }
        let deviceHeading = heading.headingInDegrees
        relativeBearing = signedAngleDelta(from: deviceHeading, to: sunAzimuth)
        isBacklit = checkBacklit(relativeBearing: relativeBearing, sunElevation: sunElevation, currentState: isBacklit)
    }
    
    private func checkBacklit(relativeBearing: Double, sunElevation: Double, currentState: Bool) -> Bool {
        guard sunElevation > -0.833 else { return false }
        let bearingAbs = abs(relativeBearing)
        
        if currentState {
            return bearingAbs <= 50.0
        } else {
            return bearingAbs <= 45.0
        }
    }
    
    private func signedAngleDelta(from a: Double, to b: Double) -> Double {
        var delta = (b - a).truncatingRemainder(dividingBy: 360)
        if delta > 180 { delta -= 360 }
        if delta <= -180 { delta += 360 }
        return delta
    }
}
