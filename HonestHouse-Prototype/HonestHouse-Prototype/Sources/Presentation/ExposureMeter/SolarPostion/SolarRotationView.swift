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
    
    private let refreshInterval: TimeInterval = 600.0
    @State private var timerCancellable: AnyCancellable?
    
    var body: some View {
        ZStack(alignment: .top) {
            Circle().stroke(Color.white.opacity(0.5), lineWidth: 5).frame(width: 107, height: 107)
            Image(.sun)
                .padding(.top, -25)
        }
        .rotationEffect(.degrees(relativeBearing))
        .animation(.easeInOut(duration: 0.12), value: relativeBearing)
        
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
                updateRelativeBearing()
            }
        }
        .onChange(of: heading.headingInDegrees) {
            updateRelativeBearing()
        }
        .onChange(of: solar.azimuth) {
            updateRelativeBearing()
        }
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: refreshInterval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                _ = solar.refresh()
                updateRelativeBearing()
            }
    }
    
    private func updateRelativeBearing() {
        guard let sunAzimuth = solar.azimuth else { return }
        let deviceHeading = heading.headingInDegrees
        relativeBearing = signedAngleDelta(from: deviceHeading, to: sunAzimuth)
    }
    
    private func signedAngleDelta(from a: Double, to b: Double) -> Double {
        var delta = (b - a).truncatingRemainder(dividingBy: 360)
        if delta > 180 { delta -= 360 }
        if delta <= -180 { delta += 360 }
        return delta
    }
}

#Preview {
    SolarRotationView()
}
