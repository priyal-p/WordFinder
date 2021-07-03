//
//  WordFinder.swift
//  wordfinder
//
//  Created by Priyal PORWAL on 02/07/21.
//

import Foundation
struct WordFinder {
    enum Constants: Character {
        case wildcard = "."
    }
    let wordList: [String]
    let isCaseSensitive: Bool
    init(wordListPath: String, isCaseSensitive: Bool) throws {
        let wordListContent = try String.init(contentsOfFile: wordListPath)
        wordList = wordListContent.components(separatedBy: .newlines)
        self.isCaseSensitive = isCaseSensitive
    }
    func caseCorrected(word: String) -> String {
        isCaseSensitive ? word : word.lowercased()
    }
    
    func isMatch(template t: String, word w: String) -> Bool {
        let template = caseCorrected(word: t)
        let word = caseCorrected(word: w)
        if template.count != word.count {
            return false
        }
        return template.indices.allSatisfy { index in
            template[index] == Constants.wildcard.rawValue || template[index] == word[index]
        }
    }
    
    func filterWords(for template: String) -> [String] {
        return wordList.filter { word in
            isMatch(template: template, word: word)
        }
    }
}
