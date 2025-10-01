//
//  ModeRule.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct ModeRule {
    let place: String
    let subject: String
    let motion: String
    let dof: Bool?
    let night: Bool?
    let result: ModeSubtype
}

let rules: [ModeRule] = [
    ModeRule(place: "indoor", subject: "landscape", motion: "", dof: nil, night: nil, result: .A1),
    ModeRule(place: "indoor", subject: "people", motion: "dynamic", dof: true, night: nil, result: .M1),
    ModeRule(place: "indoor", subject: "people", motion: "dynamic", dof: false, night: nil, result: .S),
    ModeRule(place: "indoor", subject: "people", motion: "static", dof: true, night: nil, result: .A2),
    ModeRule(place: "indoor", subject: "people", motion: "static", dof: false, night: nil, result: .A3),
    ModeRule(place: "outdoor", subject: "landscape", motion: "", dof: nil, night: true, result: .M2),
    ModeRule(place: "outdoor", subject: "landscape", motion: "", dof: nil, night: false, result: .A3),
    ModeRule(place: "outdoor", subject: "people", motion: "dynamic", dof: true, night: nil, result: .M1),
    ModeRule(place: "outdoor", subject: "people", motion: "dynamic", dof: false, night: nil, result: .S),
    ModeRule(place: "outdoor", subject: "people", motion: "static", dof: true, night: nil, result: .A2),
    ModeRule(place: "outdoor", subject: "people", motion: "static", dof: false, night: nil, result: .A3),
]
