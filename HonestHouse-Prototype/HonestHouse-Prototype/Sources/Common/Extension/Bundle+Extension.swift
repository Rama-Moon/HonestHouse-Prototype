//
//  Bundle+Extension.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 10/1/25.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let key = infoDictionary?["API_KEY"] as? String else {
            fatalError("@Log - Can't find API_KEY")
        }
        return key
    }
    
    var apiBaseURL: String {
        guard let url = infoDictionary?["API_BASE_URL"] as? String else {
            fatalError("@Log - Can't find API_BASE_URL")
        }
        return url
    }
}
