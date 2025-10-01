//
//  SolarManager.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 10/1/25.
//

import Foundation

public final class SolarManager: ObservableObject {
    public static let shared = SolarManager()
    
    @Published public private(set) var elevation: Double?
    @Published public private(set) var azimuth: Double?
    @Published public private(set) var status: SunStatus = .noSun
    
    public private(set) var latitude: Double = 0.0
    public private(set) var longitude: Double = 0.0
    
    private init() {}
    
    public func updateCoordinates(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    /// 지정한 시각(기본값: 현재)으로 내부 상태를 갱신하고 상태를 반환합니다.
    @discardableResult
    public func refresh(at date: Date = Date()) -> SunStatus {
        let position = SolarPosition.compute(latitude: latitude, longitude: longitude, date: date)
        let newStatus: SunStatus = (position.elevation > -0.833)
            ? .sunUp(elevation: position.elevation, azimuth: position.azimuth)
            : .noSun
        
        switch newStatus {
        case .sunUp(let elev, let az):
            elevation = elev
            azimuth = az
        case .noSun:
            elevation = nil
            azimuth = nil
        }
        status = newStatus
        return newStatus
    }
    
    
    /// 입력 받은 시각을 기준으로 하는 태양의 고도, 방위각, 상태를 계산 후 반환합니다.
    public func compute(at date: Date = Date()) -> (elevation: Double, azimuth: Double, status: SunStatus) {
        let position = SolarPosition.compute(latitude: latitude, longitude: longitude, date: date)
        let newStatus: SunStatus = (position.elevation > -0.833)
            ? .sunUp(elevation: position.elevation, azimuth: position.azimuth)
            : .noSun
        return (position.elevation, position.azimuth, newStatus)
    }
    
    /// 입력 받은 시각을 기준으로 태양이 떠있는지에 대한 Bool값을 반환합니다.
    public func isSunUp(at date: Date = Date()) -> Bool {
        let position = SolarPosition.compute(latitude: latitude, longitude: longitude, date: date)
        return position.elevation > -0.833
    }
}

extension SolarManager {
    struct SolarPosition {
        let elevation: Double
        let azimuth: Double
        
        static func compute(latitude: Double, longitude: Double, date: Date) -> SolarPosition {
            func degreesToRadians(_ degrees: Double) -> Double { degrees * .pi / 180 }
            func radiansToDegrees(_ radians: Double) -> Double { radians * 180 / .pi }

            let utc = TimeZone(secondsFromGMT: 0)!
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = utc
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            let year = components.year!
            let month = components.month!
            let day = components.day!
            let universalTime = Double(components.hour ?? 0) + Double(components.minute ?? 0) / 60 + Double(components.second ?? 0) / 3600
            
            // Julian Day Number/Day (정수/실수) 및 세기
            let monthAdjustment = floor(Double(14 - month) / 12.0)
            let adjustedYear = Double(year) + 4800 - monthAdjustment
            let adjustedMonth = Double(month) + 12 * monthAdjustment - 3
            
            let julianDayNumber = Double(day) + floor((153 * adjustedMonth + 2) / 5) + 365 * adjustedYear + floor(adjustedYear / 4) - floor(adjustedYear / 100) + floor(adjustedYear / 400) - 32045
            
            let julianDay = julianDayNumber + (universalTime - 12.0) / 24.0
            let julianCenturies = (julianDay - 2451545.0) / 36525.0
            
            // 태양 궤도 요소
            let meanLongitude = fmod(280.46646 + julianCenturies * (36000.76983 + julianCenturies * 0.0003032), 360)
            let meanAnomaly = 357.52911 + julianCenturies * (35999.05029 - 0.0001537 * julianCenturies)
            let eccentricity = 0.016708634 - julianCenturies * (0.000042037 + 0.0000001267 * julianCenturies)
            
            let meanAnomalyRad = degreesToRadians(meanAnomaly)
            let equationOfCenter = (1.914602 - julianCenturies * (0.004817 + 0.000014 * julianCenturies)) * sin(meanAnomalyRad) + (0.019993 - 0.000101 * julianCenturies) * sin(2 * meanAnomalyRad) + 0.000289 * sin(3 * meanAnomalyRad)
            
            let trueLongitude = meanLongitude + equationOfCenter
            
            // 기울기/장동 보정
            let omega = 125.04 - 1934.136 * julianCenturies
            let apparentLongitude = trueLongitude - 0.00569 - 0.00478 * sin(degreesToRadians(omega))
            
            let centuriesScaled = julianCenturies / 100.0
            let meanObliquity = 23 + (26 + (21.448 - centuriesScaled * (46.815 + centuriesScaled * (0.00059 - centuriesScaled * 0.001813))) / 60) / 60
            let obliquity = meanObliquity + 0.00256 * cos(degreesToRadians(omega))
            
            // 적위(Declination)
            let declination = asin(sin(degreesToRadians(obliquity)) * sin(degreesToRadians(apparentLongitude)))
            
            // 균시차(분)
            let tanObliquityHalf = tan(degreesToRadians(obliquity / 2))
            let yTerm = tanObliquityHalf * tanObliquityHalf
            let equationOfTime = 4 * radiansToDegrees(yTerm * sin(2 * degreesToRadians(meanLongitude)) - 2 * eccentricity * sin(meanAnomalyRad) + 4 * eccentricity * yTerm * sin(meanAnomalyRad) * cos(2 * degreesToRadians(meanLongitude)) - 0.5 * yTerm * yTerm * sin(4 * degreesToRadians(meanLongitude)) - 1.25 * eccentricity * eccentricity * sin(2 * meanAnomalyRad))
            
            // 태양시 & 시간각
            let localSolarTime = universalTime + longitude / 15.0 + equationOfTime / 60.0
            let hourAngleDegrees = (localSolarTime - 12.0) * 15.0
            
            // 고도/방위 계산
            let latitudeRad = degreesToRadians(latitude)
            let hourAngleRad = degreesToRadians(hourAngleDegrees)
            
            let sinAltitude = sin(latitudeRad) * sin(declination) + cos(latitudeRad) * cos(declination) * cos(hourAngleRad)
            
            let altitude = asin(max(-1, min(1, sinAltitude)))
            
            let cosAzimuth = (sin(declination) - sin(latitudeRad) * sin(altitude)) / (cos(latitudeRad) * cos(altitude))
            
            var azimuthRad = acos(max(-1, min(1, cosAzimuth)))
            if hourAngleDegrees > 0 { azimuthRad = 2 * .pi - azimuthRad }
            
            return .init(
                elevation: radiansToDegrees(altitude),
                azimuth: fmod(radiansToDegrees(azimuthRad) + 360.0, 360.0)
            )
        }
    }
}
