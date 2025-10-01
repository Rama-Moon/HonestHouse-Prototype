//
//  HeadingManager.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 10/1/25.
//

import Foundation
import CoreLocation
import Combine

/// 진북 기준 헤딩(0~360°) 제공
public final class HeadingManager: NSObject, ObservableObject {
    public static let shared = HeadingManager()
    
    @Published public private(set) var headingInDegrees: Double = 0.0
    
    private let locationManager = CLLocationManager()
    private var isRunning = false
    
    private let smoothingAlpha: Double = 0.2
    private var hasInitialValue = false
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.headingFilter = 1 // 1도 변화마다
    }
    
    public func start() {
        guard CLLocationManager.headingAvailable() else { return }
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingHeading()
        isRunning = true
    }
    
    public func stop() {
        guard isRunning else { return }
        locationManager.stopUpdatingHeading()
        isRunning = false
        hasInitialValue = false
    }
}

extension HeadingManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            if isRunning { manager.startUpdatingHeading() }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        // trueHeading 우선으로 heading 측정, 없으면 magneticHeading
        let raw = (newHeading.trueHeading >= 0) ? newHeading.trueHeading : newHeading.magneticHeading
        let current = headingInDegrees
        
        let next: Double
        if !hasInitialValue {
            hasInitialValue = true
            next = raw
        } else {
            // 원형 평균: signed delta만큼 천천히 따라가도록
            var delta = (raw - current).truncatingRemainder(dividingBy: 360)
            if delta > 180 { delta -= 360 }
            if delta <= -180 { delta += 360 }
            next = current + smoothingAlpha * delta
        }
        
        var normalized = next.truncatingRemainder(dividingBy: 360)
        if normalized < 0 { normalized += 360 }
        headingInDegrees = normalized
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}
