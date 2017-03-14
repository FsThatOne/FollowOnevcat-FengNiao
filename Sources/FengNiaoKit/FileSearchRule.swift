//
//  FileSearchRule.swift
//  FengNiao
//
//  Created by 王正一 on 2017/3/14.
//
//

import Foundation

protocol StringSeacher {
    func search(in content: String) -> Set<String>
}

protocol RegexStringSearcher: StringSeacher {
    var patterns: [String] { get }
}

extension RegexStringSearcher {
    func search(in content: String) -> Set<String> {
        
        var result = Set<String>()
        
        
        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                print("Failed to create regular expression: \(pattern)")
                continue
            }
            
            let matches = regex.matches(in: content, options: [], range: content.fullRange)
            for checkingResult in matches {
                let range = checkingResult.rangeAt(1)
                let extracted = NSString(string: content).substring(with: range)
                result.insert(extracted.plainName)
            }
        }
        return []
    }
}

