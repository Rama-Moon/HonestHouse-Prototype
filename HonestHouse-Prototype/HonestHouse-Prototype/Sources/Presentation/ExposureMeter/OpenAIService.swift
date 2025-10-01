//
//  OpenAIService.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

import Foundation

class OpenAIService {
    private let session = URLSession.shared
    
    func sendMessage(messages: [ChatMessage]) async throws -> String {
        guard let url = URL(string: OpenAIConfig.baseURL) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(OpenAIConfig.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ChatRequest(
            model: "gpt-4o-mini-2024-07-18",
            messages: messages,
            maxTokens: 1000,
            temperature: 0.7
        )
        
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, _) = try await session.data(for: request)
        let response = try JSONDecoder().decode(ChatResponse.self, from: data)
        
        return response.choices.first?.message.content ?? ""
    }
}
