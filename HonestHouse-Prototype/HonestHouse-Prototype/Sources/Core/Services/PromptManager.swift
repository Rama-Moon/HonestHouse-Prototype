//
//  PromptManager.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

import SwiftUI

class PromptManager {
    static func createPhotographyAssistant(
        A: Double,
        SS: Double,
        ISO: Int
    ) -> [ChatMessage] {
        let systemPrompt = """
        당신은 전문 사진 촬영 어시스턴트입니다.
        
        역할:
        - 빛의 3요소를 결정(조리개, 셔터스피드, ISO)에 대한 이유 제시
        
        답변 스타일:
        - 전문용어 사용 시 간단한 부연설명 추가
        
        금지사항:
        - 30글자가 넘는 답변
        """
        
        return [
            ChatMessage(role: "system", content: systemPrompt)
        ]
    }
}
