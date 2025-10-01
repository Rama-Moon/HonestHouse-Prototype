//
//  ChatMessage.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

struct ChatMessage: Codable {
    let role: String // "system", "user", "assistant"
    let content: String
}
