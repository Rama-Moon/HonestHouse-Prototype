//
//  ModeRule.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 10/1/25.
//

import Foundation

struct ModeRule {
    let place: Place
    let subject: Subject
    let motion: Movements?
    let dof: DOF?
    let night: Bool?
    let result: ModeSubtype
}

let rules: [ModeRule] = [
    ModeRule(place: .indoor, subject: .scenery, motion: nil, dof: nil, night: nil, result: .A1),
    ModeRule(place: .indoor, subject: .stillLife, motion: .dynamic, dof: .shallow, night: nil, result: .M1),
    ModeRule(place: .indoor, subject: .stillLife, motion: .dynamic, dof: .deep, night: nil, result: .S),
    ModeRule(place: .indoor, subject: .stillLife, motion: .stillness, dof: .shallow, night: nil, result: .A2),
    ModeRule(place: .indoor, subject: .stillLife, motion: .stillness, dof: .deep, night: nil, result: .A3),
    ModeRule(place: .outdoor, subject: .scenery, motion: nil, dof: nil, night: true, result: .M2),
    ModeRule(place: .outdoor, subject: .scenery, motion: nil, dof: nil, night: false, result: .A3),
    ModeRule(place: .outdoor, subject: .stillLife, motion: .dynamic, dof: .shallow, night: nil, result: .M1),
    ModeRule(place: .outdoor, subject: .stillLife, motion: .dynamic, dof: .deep, night: nil, result: .S),
    ModeRule(place: .outdoor, subject: .stillLife, motion: .stillness, dof: .shallow, night: nil, result: .A2),
    ModeRule(place: .outdoor, subject: .stillLife, motion: .stillness, dof: .deep, night: nil, result: .A3),
]
