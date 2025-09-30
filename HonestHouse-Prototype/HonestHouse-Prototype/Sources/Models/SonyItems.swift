//
//  SonyItems.swift
//  HonestHouse-Prototype
//
//  Created by BoMin Lee on 9/30/25.
//

import Foundation

struct SonyItems {
    static let bodies: [CameraBody] = [
        // 풀프레임 (E 마운트)
        CameraBody(name: "a7",      fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7 II",   fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7 III",  fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7 IV",   fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7R",     fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7R II",  fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7R III", fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7R IV",  fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7R V",   fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7S",     fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7S II",  fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7S III", fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7C",     fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7C II",  fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a7CR",    fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a9",      fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a9 II",   fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a9 III",  fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0),
        CameraBody(name: "a1",      fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0),
        CameraBody(name: "a1 II",   fastestShutterSpeed: 1.0/32000.0, slowestShutterSpeed: 30.0),
        CameraBody(name: "ZV-E1",   fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "FX3",     fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),

        // APS-C (E 마운트)
        CameraBody(name: "a6000",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a6100",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a6300",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a6400",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a6500",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a6600",   fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "a6700",   fastestShutterSpeed: 1.0/8000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "ZV-E10",  fastestShutterSpeed: 1.0/4000.0,  slowestShutterSpeed: 30.0),
        CameraBody(name: "ZV-E10 II",fastestShutterSpeed: 1.0/4000.0, slowestShutterSpeed: 30.0)
    ]
    
    static let lenses: [CameraLens] = [
        // --- 풀프레임 FE 줌렌즈 ---
        CameraLens(name: "FE 12–24mm F2.8 GM",           maxOpenAperture: 2.8),
        CameraLens(name: "FE 12–24mm F4 G",              maxOpenAperture: 4.0),
        CameraLens(name: "FE 16–25mm F2.8 G",            maxOpenAperture: 2.8),
        CameraLens(name: "FE 16–35mm F2.8 GM",           maxOpenAperture: 2.8),
        CameraLens(name: "FE 16–35mm F2.8 GM II",        maxOpenAperture: 2.8),
        CameraLens(name: "FE C 16–35mm T3.1 G",          maxOpenAperture: 3.1), // T-stop 그대로 반영
        CameraLens(name: "FE 16–35mm F4 ZA OSS",         maxOpenAperture: 4.0),
        CameraLens(name: "FE PZ 16–35mm F4 G",           maxOpenAperture: 4.0),
        CameraLens(name: "FE 20–70mm F4 G",              maxOpenAperture: 4.0),
        CameraLens(name: "FE 24–50mm F2.8 G",            maxOpenAperture: 2.8),
        CameraLens(name: "FE 24–70mm F2.8 GM",           maxOpenAperture: 2.8),
        CameraLens(name: "FE 24–70mm F2.8 GM II",        maxOpenAperture: 2.8),
        CameraLens(name: "FE 24–70mm F4 ZA OSS",         maxOpenAperture: 4.0),
        CameraLens(name: "FE 24–105mm F4 G OSS",         maxOpenAperture: 4.0),
        CameraLens(name: "FE 28–60mm F4–5.6",            maxOpenAperture: 4.0),
        CameraLens(name: "FE 28–70mm F3.5–5.6 OSS",      maxOpenAperture: 3.5),
        CameraLens(name: "FE 28–70mm F2 GM",             maxOpenAperture: 2.0),
        CameraLens(name: "FE PZ 28–135mm F4 G OSS",      maxOpenAperture: 4.0),
        CameraLens(name: "FE 50–150mm F2 GM",            maxOpenAperture: 2.0),
        CameraLens(name: "FE 70–200mm F2.8 GM OSS",      maxOpenAperture: 2.8),
        CameraLens(name: "FE 70–200mm F2.8 GM OSS II",   maxOpenAperture: 2.8),
        CameraLens(name: "FE 70–200mm F4 G OSS",         maxOpenAperture: 4.0),
        CameraLens(name: "FE 70–200mm F4 Macro G OSS II",maxOpenAperture: 4.0),
        CameraLens(name: "FE 70–300mm F4.5–5.6 G OSS",   maxOpenAperture: 4.5),
        CameraLens(name: "FE 100–400mm F4.5–5.6 GM OSS", maxOpenAperture: 4.5),
        CameraLens(name: "FE 200–600mm F5.6–6.3 G OSS",  maxOpenAperture: 5.6),
        CameraLens(name: "FE 400–800mm F6.3–8 G OSS",    maxOpenAperture: 6.3),
        CameraLens(name: "FE 24–240mm F3.5–6.3 OSS",     maxOpenAperture: 3.5),
        
        // --- 풀프레임 FE 단렌즈 ---
        CameraLens(name: "FE 14mm F1.8 GM",              maxOpenAperture: 1.8),
        CameraLens(name: "FE 16mm F1.8 G",               maxOpenAperture: 1.8),
        CameraLens(name: "FE 20mm F1.8 G",               maxOpenAperture: 1.8),
        CameraLens(name: "FE 24mm F1.4 GM",              maxOpenAperture: 1.4),
        CameraLens(name: "FE 24mm F2.8 G",               maxOpenAperture: 2.8),
        CameraLens(name: "FE 28mm F2",                   maxOpenAperture: 2.0),
        CameraLens(name: "FE 35mm F1.4 ZA",              maxOpenAperture: 1.4),
        CameraLens(name: "FE 35mm F1.4 GM",              maxOpenAperture: 1.4),
        CameraLens(name: "FE 35mm F1.8",                 maxOpenAperture: 1.8),
        CameraLens(name: "FE 35mm F2.8 ZA",              maxOpenAperture: 2.8),
        CameraLens(name: "FE 40mm F2.5 G",               maxOpenAperture: 2.5),
        CameraLens(name: "FE 50mm F1.2 GM",              maxOpenAperture: 1.2),
        CameraLens(name: "FE 50mm F1.4 ZA",              maxOpenAperture: 1.4),
        CameraLens(name: "FE 50mm F1.4 GM",              maxOpenAperture: 1.4),
        CameraLens(name: "FE 50mm F1.8",                 maxOpenAperture: 1.8),
        CameraLens(name: "FE 50mm F2.5 G",               maxOpenAperture: 2.5),
        CameraLens(name: "FE 50mm F2.8 Macro",           maxOpenAperture: 2.8),
        CameraLens(name: "FE 55mm F1.8 ZA",              maxOpenAperture: 1.8),
        CameraLens(name: "FE 85mm F1.4 GM",              maxOpenAperture: 1.4),
        CameraLens(name: "FE 85mm F1.4 GM II",           maxOpenAperture: 1.4),
        CameraLens(name: "FE 85mm F1.8",                 maxOpenAperture: 1.8),
        CameraLens(name: "FE 90mm F2.8 Macro G OSS",     maxOpenAperture: 2.8),
        CameraLens(name: "FE 100mm F2.8 STF GM OSS",     maxOpenAperture: 2.8),
        CameraLens(name: "FE 135mm F1.8 GM",             maxOpenAperture: 1.8),
        CameraLens(name: "FE 300mm F2.8 GM OSS",         maxOpenAperture: 2.8),
        CameraLens(name: "FE 400mm F2.8 GM OSS",         maxOpenAperture: 2.8),
        CameraLens(name: "FE 600mm F4 GM OSS",           maxOpenAperture: 4.0),
        
        // --- APS-C E 줌렌즈 ---
        CameraLens(name: "E 10-18mm F4 OSS",             maxOpenAperture: 4.0),
        CameraLens(name: "E PZ 10-20mm F4 G",            maxOpenAperture: 4.0),
        CameraLens(name: "E PZ 16-50mm F3.5-5.6 OSS",    maxOpenAperture: 3.5),
        CameraLens(name: "E PZ 16-50mm F3.5-5.6 OSS II", maxOpenAperture: 3.5),
        CameraLens(name: "E 16-55mm F2.8 G",             maxOpenAperture: 2.8),
        CameraLens(name: "E 16-70mm F4 ZA OSS",          maxOpenAperture: 4.0),
        CameraLens(name: "E 18-50mm F4-5.6",             maxOpenAperture: 4.0),
        CameraLens(name: "E 18-55mm F3.5-5.6 OSS",       maxOpenAperture: 3.5),
        CameraLens(name: "E PZ 18-105mm F4 G OSS",       maxOpenAperture: 4.0),
        CameraLens(name: "E PZ 18-110mm F4 G OSS",       maxOpenAperture: 4.0),
        CameraLens(name: "E 18-135mm F3.5-5.6 OSS",      maxOpenAperture: 3.5),
        CameraLens(name: "E 18-200mm F3.5-6.3 OSS",      maxOpenAperture: 3.5),
        CameraLens(name: "E 18-200mm F3.5-6.3 OSS LE",   maxOpenAperture: 3.5),
        CameraLens(name: "E PZ 18-200mm F3.5-6.3 OSS",   maxOpenAperture: 3.5),
        CameraLens(name: "E 55-210mm F4.5-6.3 OSS",      maxOpenAperture: 4.5),
        CameraLens(name: "E 70-350mm F4.5-6.3 G OSS",    maxOpenAperture: 4.5),
        
        // --- APS-C E 단렌즈 ---
        CameraLens(name: "E 11mm F1.8",                  maxOpenAperture: 1.8),
        CameraLens(name: "E 15mm F1.4 G",                maxOpenAperture: 1.4),
        CameraLens(name: "E 16mm F2.8",                  maxOpenAperture: 2.8),
        CameraLens(name: "E 20mm F2.8",                  maxOpenAperture: 2.8),
        CameraLens(name: "E 24mm F1.8 ZA",               maxOpenAperture: 1.8),
        CameraLens(name: "E 30mm F3.5 Macro",            maxOpenAperture: 3.5),
        CameraLens(name: "E 35mm F1.8 OSS",              maxOpenAperture: 1.8),
        CameraLens(name: "E 50mm F1.8 OSS",              maxOpenAperture: 1.8),
        CameraLens(name: "E 50mm F2.8 Macro",            maxOpenAperture: 2.8)
    ]
}
