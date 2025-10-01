//
//  ChatRequest.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

struct ChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
    let maxTokens: Int
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case model, messages, temperature
        case maxTokens = "max_tokens"
    }
}
