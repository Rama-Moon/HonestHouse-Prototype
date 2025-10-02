//
//  ChatResponse.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

struct ChatResponse: Codable {
    let choices: [Choice]
    
    struct Choice: Codable {
        let message: ChatMessage
    }
}
