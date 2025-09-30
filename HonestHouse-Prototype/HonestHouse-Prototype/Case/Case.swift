//
//  Case.swift
//  HonestHouse-Prototype
//
//  Created by 이현주 on 9/30/25.
//

import Foundation

enum Place: String, CaseIterable, Hashable {
    case indoor = "실내"
    case outdoor = "실외"
}

enum Subject: String, CaseIterable, Hashable {
    case stillLife = "인물/동물"
    case scenery = "풍경"
}

enum Movements: String, CaseIterable, Hashable {
    case dynamic = "동적"
    case stillness = "정적"
}

enum DOF: String, CaseIterable, Hashable {
    case shallow = "O"
    case deep = "X"
}
