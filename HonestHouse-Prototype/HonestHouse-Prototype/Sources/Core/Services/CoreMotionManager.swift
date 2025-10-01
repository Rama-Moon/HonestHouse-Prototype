//
//  CoreMotionManager.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 10/1/25.
//

import Foundation
import CoreMotion

/// 진북 기준 헤딩(0~360°)과 피치(위, 아래)를 제공한다
public final class CoreMotionManager: ObservableObject {
    public static let shared = CoreMotionManager()
    
    @Published public private(set) var headingInDegrees: Double = 0.0   //
    @Published public private(set) var pitchInDegrees: Double = 0.0     //
    
    private let motionManager = CMMotionManager()
    
    private init() {}
    
    /// CoreMotion 기반 헤딩/피치 업데이트 시작
    /// - Parameter updatesPerSecond: 초당 업데이트 횟수 (기본값: 30Hz)
    public func start(updatesPerSecond: Double = 30.0) {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0 / updatesPerSecond
        
        motionManager.startDeviceMotionUpdates(using: .xTrueNorthZVertical, to: .main) { [weak self] deviceMotion, _ in
            guard let self, let deviceMotion else { return }
            
            // pitch (라디안 -> 도)
            let pitchRadians = deviceMotion.attitude.pitch
            let pitchAsDegrees = pitchRadians * 180.0 / .pi
            
            // yaw (라디안 -> 도, 0° = 북쪽)
            var headingAsDegrees = deviceMotion.attitude.yaw * 180.0 / .pi
            headingAsDegrees = fmod(headingAsDegrees + 360.0, 360.0)
            
            self.pitchInDegrees = pitchAsDegrees
            self.headingInDegrees = headingAsDegrees
        }
    }
    
    /// 업데이트 중지
    public func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
}
