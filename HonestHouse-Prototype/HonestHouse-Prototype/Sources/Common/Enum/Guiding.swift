//
//  Guiding.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/2/25.
//

import Foundation

enum Guiding: CaseIterable {
    case indoorScenery
    case outdoorScenery
    case indoorStillLifeDynamicShallow
    case indoorStillLifeDynamicDeep
    case indoorStillLifeStillnessShallow
    case indoorStillLifeStillnessDeep
    case outdoorStillLifeDynamicShallow
    case outdoorStillLifeDynamicDeep
    case outdoorStillLifeStillnessShallow
    case outdoorStillLifeStillnessDeep
    
    var intent: Intent {
        switch self {
        case .indoorScenery:
            return Intent(place: .indoor, subject: .scenery, movement: nil, dof: nil)
        case .outdoorScenery:
            return Intent(place: .outdoor, subject: .scenery, movement: nil, dof: nil)
        case .indoorStillLifeDynamicShallow:
            return Intent(place: .indoor, subject: .stillLife, movement: .dynamic, dof: .shallow)
        case .indoorStillLifeDynamicDeep:
            return Intent(place: .indoor, subject: .stillLife, movement: .dynamic, dof: .deep)
        case .indoorStillLifeStillnessShallow:
            return Intent(place: .indoor, subject: .stillLife, movement: .stillness, dof: .shallow)
        case .indoorStillLifeStillnessDeep:
            return Intent(place: .indoor, subject: .stillLife, movement: .stillness, dof: .deep)
        case .outdoorStillLifeDynamicShallow:
            return Intent(place: .outdoor, subject: .stillLife, movement: .dynamic, dof: .shallow)
        case .outdoorStillLifeDynamicDeep:
            return Intent(place: .outdoor, subject: .stillLife, movement: .dynamic, dof: .deep)
        case .outdoorStillLifeStillnessShallow:
            return Intent(place: .outdoor, subject: .stillLife, movement: .stillness, dof: .shallow)
        case .outdoorStillLifeStillnessDeep:
            return Intent(place: .outdoor, subject: .stillLife, movement: .stillness, dof: .deep)
        }
    }
    
    var description: String {
        switch self {
        case .indoorScenery:
            return "사진이 너무 흔들린다면 셔터스피드가 느리기 때문일 수 있으니, 셔터스피드를 빠르게하고 ISO를 높여보세요\n삼각대를 사용하는 것도 좋습니다!\n피사체 앞에 거슬리는 물체가 있다면 조리개를 더 개방해서 아웃포커싱을 만드는 것도 좋아요."
        case .outdoorScenery:
            return "사진이 너무 흔들린다면 셔터스피드가 느리기 때문일 수 있으니, 셔터스피드를 빠르게하고 ISO를 높여보세요\n삼각대를 사용하는 것도 좋습니다!\n피사체 앞에 거슬리는 물체가 있다면 조리개를 더 개방해서 아웃포커싱을 만드는 것도 좋아요."
        case .indoorStillLifeDynamicShallow:
            return "피사체가 흔들린다면 조리개를 더 개방하거나 ISO를 높여보세요.\n6400이 넘어가면 노이즈가 상당히 심해질 수 있으니 주의하세요.\n피사체가 노랗게 나온다면 색온도를 낮춰보세요."
        case .indoorStillLifeDynamicDeep:
            return "여전히 피사체가 흔들리게 찍힌다면 셔터스피드를 빠르게하고 ISO를 높여보세요.\nISO가 6400이 넘어가면 노이즈가 상당히 심해질 수 있으니 주의하세요.\n피사체가 노랗게 나온다면 색온도를 낮춰보세요."
        case .indoorStillLifeStillnessShallow:
            return "아웃포커싱을 더 강하게 주고 싶다면 조리개를 더 개방하거나, 단렌즈를 사용해보세요.\n조리개가 최대 개방 상태이면 화질 저하가 발생할 수 있어요."
        case .indoorStillLifeStillnessDeep:
            return "피사체가 노랗게 나온다면 색온도를 낮춰보세요.\n피사체가 흔들리게 찍힌다면 셔터스피드를 빠르게하고 ISO를 높여보세요."
        case .outdoorStillLifeDynamicShallow:
            return "피사체가 흔들린다면 조리개를 더 개방하거나 ISO를 높여보세요.\nISO가 6400이 넘어가면 노이즈가 상당히 심해질 수 있으니 주의하세요."
        case .outdoorStillLifeDynamicDeep:
            return "여전히 피사체가 흔들리게 찍힌다면 셔터스피드를 빠르게하고 ISO를 높여보세요.\nISO가 6400이 넘어가면 노이즈가 상당히 심해질 수 있으니 주의하세요."
        case .outdoorStillLifeStillnessShallow:
            return "아웃포커싱을 더 강하게 주고 싶다면 조리개를 더 개방하거나, 단렌즈를 사용해보세요.\n조리개가 최대 개방 상태이면 화질 저하가 발생할 수 있어요."
        case .outdoorStillLifeStillnessDeep:
            return "피사체가 노랗게 나온다면 색온도를 낮춰보세요.\n피사체가 흔들리게 찍힌다면 셔터스피드를 빠르게하고 ISO를 높여보세요."
        }
    }
    
    static func from(_ intent: Intent) -> Guiding? {
        return Guiding.allCases.first { $0.intent == intent }
    }
}
