//
//  NikonItems.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation

struct NikonItems {
    static let bodies: [CameraBody] = [
        // 풀프레임 (FX)
        CameraBody(name: "Z5",    fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z5 II", fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z6",    fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z6 II", fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z6 III",fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z7",    fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z7 II", fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z8",    fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Z9",    fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0, cropFactor: 1.0),
        CameraBody(name: "Zf",    fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.0),

        // APS-C (DX)
        CameraBody(name: "Z50",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.5),
        CameraBody(name: "Z50 II",fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.5),
        CameraBody(name: "Zfc",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0, cropFactor: 1.5),
        CameraBody(name: "Z30",   fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0, cropFactor: 1.5)
    ]

    static let lenses: [CameraLens] = [
        // --- 풀프레임 FX 줌렌즈 ---
        CameraLens(name: "NIKKOR Z 14–24mm F2.8 S",                 maxOpenAperture: 2.8, focalLength: 24.0),
        CameraLens(name: "NIKKOR Z 24–50mm F4–6.3",                  maxOpenAperture: 4.0, focalLength: 50.0),
        CameraLens(name: "NIKKOR Z 24–70mm F2.8 S (I, II)",          maxOpenAperture: 2.8, focalLength: 70.0),
        CameraLens(name: "NIKKOR Z 24–70mm F4 S",                    maxOpenAperture: 4.0, focalLength: 70.0),
        CameraLens(name: "NIKKOR Z 24–120mm F4 S",                   maxOpenAperture: 4.0, focalLength: 120.0),
        CameraLens(name: "NIKKOR Z 28–75mm F2.8",                    maxOpenAperture: 2.8, focalLength: 75.0),
        CameraLens(name: "NIKKOR Z 28–135mm F4 PZ",                  maxOpenAperture: 4.0, focalLength: 135.0),
        CameraLens(name: "NIKKOR Z 70–180mm F2.8",                   maxOpenAperture: 2.8, focalLength: 180.0),
        CameraLens(name: "NIKKOR Z 70–200mm F2.8 VR S",              maxOpenAperture: 2.8, focalLength: 200.0),
        CameraLens(name: "NIKKOR Z 100–400mm F4.5–5.6 VR S",         maxOpenAperture: 4.5, focalLength: 400.0),
        CameraLens(name: "NIKKOR Z 180–600mm F5.6–6.3 VR S",         maxOpenAperture: 5.6, focalLength: 600.0),
        CameraLens(name: "NIKKOR Z 24–200mm F4–6.3 VR",              maxOpenAperture: 4.0, focalLength: 200.0),
        CameraLens(name: "NIKKOR Z 70–300mm F4.5–5.6 VR",            maxOpenAperture: 4.5, focalLength: 300.0),
        CameraLens(name: "NIKKOR Z 24–200mm F4–6.3 VR S Super Zoom", maxOpenAperture: 4.0, focalLength: 200.0),
        CameraLens(name: "NIKKOR Z 28–500mm F4–6.3 VR S Super Zoom", maxOpenAperture: 4.0, focalLength: 500.0),
        CameraLens(name: "NIKKOR Z 14–30mm F4 S Super Wide Zoom",    maxOpenAperture: 4.0, focalLength: 30.0),

        // --- 풀프레임 FX 단렌즈 ---
        CameraLens(name: "NIKKOR Z 20mm f/1.8 S",        maxOpenAperture: 1.8, focalLength: 20.0),
        CameraLens(name: "NIKKOR Z 24mm f/1.8 S",        maxOpenAperture: 1.8, focalLength: 24.0),
        CameraLens(name: "NIKKOR Z 26mm f/2.8",          maxOpenAperture: 2.8, focalLength: 26.0),
        CameraLens(name: "NIKKOR Z 28mm f/2.8",          maxOpenAperture: 2.8, focalLength: 28.0),
        CameraLens(name: "NIKKOR Z 35mm f/1.2 S",        maxOpenAperture: 1.2, focalLength: 35.0),
        CameraLens(name: "NIKKOR Z 35mm f/1.4 S",        maxOpenAperture: 1.4, focalLength: 35.0),
        CameraLens(name: "NIKKOR Z 35mm f/1.8 S",        maxOpenAperture: 1.8, focalLength: 35.0),
        CameraLens(name: "NIKKOR Z 40mm f/2 S",          maxOpenAperture: 2.0, focalLength: 40.0),
        CameraLens(name: "NIKKOR Z 50mm f/1.2 S",        maxOpenAperture: 1.2, focalLength: 50.0),
        CameraLens(name: "NIKKOR Z 50mm f/1.8 S",        maxOpenAperture: 1.8, focalLength: 50.0),
        CameraLens(name: "NIKKOR Z 58mm f/0.95 S Noct",  maxOpenAperture: 0.95, focalLength: 58.0),
        CameraLens(name: "NIKKOR Z 85mm f/1.2 S",        maxOpenAperture: 1.2, focalLength: 85.0),
        CameraLens(name: "NIKKOR Z 85mm f/1.8 S",        maxOpenAperture: 1.8, focalLength: 85.0),
        CameraLens(name: "NIKKOR Z 105mm f/1.4 E",       maxOpenAperture: 1.4, focalLength: 105.0),
        CameraLens(name: "NIKKOR Z MC 50mm f/2.8",       maxOpenAperture: 2.8, focalLength: 50.0),
        CameraLens(name: "NIKKOR Z MC 105mm f/2.8 VR S", maxOpenAperture: 2.8, focalLength: 105.0),

        // --- 크롭 DX 렌즈 (여기 5개는 단렌즈 스펙) ---
        CameraLens(name: "NIKKOR Z DX 16mm f/2.8",       maxOpenAperture: 2.8, focalLength: 16.0),
        CameraLens(name: "NIKKOR Z DX 24mm f/1.8 S",     maxOpenAperture: 1.8, focalLength: 24.0),
        CameraLens(name: "NIKKOR Z DX 28mm f/2.8",       maxOpenAperture: 2.8, focalLength: 28.0),
        CameraLens(name: "NIKKOR Z DX 40mm f/2",         maxOpenAperture: 2.0, focalLength: 40.0),
        CameraLens(name: "NIKKOR Z DX 50mm f/1.8 S",     maxOpenAperture: 1.8, focalLength: 50.0),

        // --- 크롭 DX 줌렌즈 ---
        CameraLens(name: "NIKKOR Z DX 16–50mm F3.5–6.3 VR",            maxOpenAperture: 3.5, focalLength: 50.0),
        CameraLens(name: "NIKKOR Z DX 18–140mm F3.5–6.3 VR",           maxOpenAperture: 3.5, focalLength: 140.0),
        CameraLens(name: "NIKKOR Z DX 18–200mm F4–6.3 VR",             maxOpenAperture: 4.0, focalLength: 200.0),
        CameraLens(name: "NIKKOR Z DX 50–250mm F4.5–6.3 VR",           maxOpenAperture: 4.5, focalLength: 250.0),
        CameraLens(name: "NIKKOR Z DX 24–70mm F4–6.3 VR Kit Zoom",     maxOpenAperture: 4.0, focalLength: 70.0),
        CameraLens(name: "NIKKOR Z DX 10–20mm F4.5–6.3 VR Super Wide", maxOpenAperture: 4.5, focalLength: 20.0)
    ]
}
