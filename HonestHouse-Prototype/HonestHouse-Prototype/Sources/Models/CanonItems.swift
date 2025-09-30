//
//  CanonItems.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation

struct CanonItems {
    static let bodies: [CameraBody] = [
        // RF 시리즈
        CameraBody(name: "EOS R",           fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS RP",          fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R5",          fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R5 Mark II",  fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R6",          fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R6 Mark II",  fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R8",          fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R3",          fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R1",          fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0),
        
        // RF-S 시리즈
        CameraBody(name: "EOS R7",          fastestShutterSpeed: 1.0/16000.0, slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R10",         fastestShutterSpeed: 1.0/16000.0, slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R50",         fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R50V",        fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "EOS R100",        fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0)
    ]
    
    static let lenses: [CameraLens] = [
        // --- 풀프레임 단렌즈 ---
        CameraLens(name: "RF 5.2mm F2.8 L DUAL FISHEYE", maxOpenAperture: 2.8),
        CameraLens(name: "RF 16mm F2.8 STM",             maxOpenAperture: 2.8),
        CameraLens(name: "RF 20mm F1.4 L VCM",           maxOpenAperture: 1.4),
        CameraLens(name: "RF 24mm F1.4 L VCM",           maxOpenAperture: 1.4),
        CameraLens(name: "RF 24mm F1.8 Macro IS STM",    maxOpenAperture: 1.8),
        CameraLens(name: "RF 28mm F2.8 STM",             maxOpenAperture: 2.8),
        CameraLens(name: "RF 35mm F1.4 L VCM",           maxOpenAperture: 1.4),
        CameraLens(name: "RF 35mm F1.8 Macro IS STM",    maxOpenAperture: 1.8),
        CameraLens(name: "RF 50mm F1.2 L USM",           maxOpenAperture: 1.2),
        CameraLens(name: "RF 50mm F1.4 L VCM",           maxOpenAperture: 1.4),
        CameraLens(name: "RF 50mm F1.8 STM",             maxOpenAperture: 1.8),
        CameraLens(name: "RF 85mm F1.2 L USM",           maxOpenAperture: 1.2),
        CameraLens(name: "RF 85mm F1.2 L USM DS",        maxOpenAperture: 1.2),
        CameraLens(name: "RF 85mm F2 Macro IS STM",      maxOpenAperture: 2.0),
        CameraLens(name: "RF 100mm F2.8 L Macro IS USM", maxOpenAperture: 2.8),
        CameraLens(name: "RF 135mm F1.8 L IS USM",       maxOpenAperture: 1.8),
        CameraLens(name: "RF 400mm F2.8 L IS USM",       maxOpenAperture: 2.8),
        CameraLens(name: "RF 600mm F4 L IS USM",         maxOpenAperture: 4.0),
        CameraLens(name: "RF 600mm F11 IS STM",          maxOpenAperture: 11.0),
        CameraLens(name: "RF 800mm F5.6 L IS USM",       maxOpenAperture: 5.6),
        CameraLens(name: "RF 800mm F11 IS STM",          maxOpenAperture: 11.0),
        CameraLens(name: "RF 1200mm F8 L IS USM",        maxOpenAperture: 8.0),
        
        // --- 풀프레임 줌렌즈 ---
        CameraLens(name: "RF 10-20mm F4 L IS STM",               maxOpenAperture: 4.0),
        CameraLens(name: "RF 14-35mm F4 L IS USM",               maxOpenAperture: 4.0),
        CameraLens(name: "RF 15-30mm F4.5-6.3 IS STM",           maxOpenAperture: 4.5),
        CameraLens(name: "RF 15-35mm F2.8 L IS USM",             maxOpenAperture: 2.8),
        CameraLens(name: "RF 16-28mm F2.8 IS STM",               maxOpenAperture: 2.8),
        CameraLens(name: "RF 24-50mm F4.5-6.3 IS STM",           maxOpenAperture: 4.5),
        CameraLens(name: "RF 24-70mm F2.8 L IS USM",             maxOpenAperture: 2.8),
        CameraLens(name: "RF 24-70mm F2.8 L IS USM Z",           maxOpenAperture: 2.8),
        CameraLens(name: "RF 24-105mm F2.8 L IS USM",            maxOpenAperture: 2.8),
        CameraLens(name: "RF 24-105mm F4 L IS USM",              maxOpenAperture: 4.0),
        CameraLens(name: "RF 24-105mm F4-7.1 IS STM",            maxOpenAperture: 4.0),
        CameraLens(name: "RF 24-240mm F4-6.3 IS USM",            maxOpenAperture: 4.0),
        CameraLens(name: "RF 28-70mm F2 L USM",                  maxOpenAperture: 2.0),
        CameraLens(name: "RF 28-70mm F2.8 IS STM",               maxOpenAperture: 2.8),
        CameraLens(name: "RF 70-200mm F2.8 L IS USM",            maxOpenAperture: 2.8),
        CameraLens(name: "RF 70-200mm F2.8 L IS USM Z",          maxOpenAperture: 2.8),
        CameraLens(name: "RF 70-200mm F4 L IS USM",              maxOpenAperture: 4.0),
        CameraLens(name: "RF 75-300mm F4-5.6",                   maxOpenAperture: 4.0),
        CameraLens(name: "RF 100-300mm F2.8 L IS USM",           maxOpenAperture: 2.8),
        CameraLens(name: "RF 100-400mm F5.6-8 IS USM",           maxOpenAperture: 5.6),
        CameraLens(name: "RF 100-500mm F4.5-7.1 L IS USM",       maxOpenAperture: 4.5),
        CameraLens(name: "RF 200-800mm F6.3-9 IS USM",           maxOpenAperture: 6.3),
        
        // --- RF-S APS-C ---
        CameraLens(name: "RF-S 24mm F1.8 Macro IS STM",          maxOpenAperture: 1.8),
        CameraLens(name: "RF-S 7.8mm f/4 STM Dual Lens",         maxOpenAperture: 4.0),
        CameraLens(name: "RF-S 10-18mm f/4.5-6.3 IS STM",        maxOpenAperture: 4.5),
        CameraLens(name: "RF-S 14-30mm f/4-6.3 IS STM PZ",       maxOpenAperture: 4.0),
        CameraLens(name: "RF-S 18-45mm f/4.5-6.3 IS STM",        maxOpenAperture: 4.5),
        CameraLens(name: "RF-S 18-150mm f/3.5-6.3 IS STM",       maxOpenAperture: 3.5),
        CameraLens(name: "RF-S 55-210mm f/5-7.1 IS STM",         maxOpenAperture: 5.0)
    ]
}
