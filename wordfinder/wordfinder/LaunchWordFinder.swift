//
//  LaunchWordFinder.swift
//  wordfinder
//
//  Created by Priyal PORWAL on 02/07/21.
//

import Foundation
import ArgumentParser
struct LaunchWordFinder: ParsableCommand {
    
    @Argument(help: """
The word template to be matched at locations . as placeholders. Leaving this blank will enter interactive mode.
""" , completion: nil)
    var templateString: String?
    
    @Flag(name: .shortAndLong, help: "Perform case-sensitive matches")
    var ignoreCase: Bool = false
    
    @Option(name: .customLong("wordfile"), help: "Path to word list")
    var pathToWordList: String = "/usr/share/dict/words"
//    enum Constants {
//        static var pathToWordList: String {
//            "/usr/share/dict/words"
//        }
//    }
    func findAndPrintMathingWords(templateWord: String) {
        do {
//            let path = Constants.pathToWordList
            let wordFinder = try WordFinder(wordListPath: pathToWordList, isCaseSensitive: ignoreCase)
            let matchingWords = wordFinder.filterWords(for: templateWord)
            print("Found \(matchingWords.count) \(matchingWords.count == 1 ? "word" : "words"):")
            for word in matchingWords {
                print(word)
            }
        } catch {
            
        }
    }
    
//    func run() throws {
//        let args = CommandLine.arguments
//        print(args)
//        var template = ""
//        if args.count > 1 {
//            template = args[1]
//            findAndPrintMathingWords(templateWord: template)
//        } else {
//            while true {
//                print("Enter word template:", terminator: "")
//                template = readLine() ?? ""
//                if template.isEmpty {
//                    return
//                }
//
//                findAndPrintMathingWords(templateWord: template)
//            }
//        }
//    }
    
    func run() throws {
        let args = CommandLine.arguments
        print(args)
        var template = ""
        if let template = templateString {
            findAndPrintMathingWords(templateWord: template)
        } else {
            while true {
                print("Enter word template:", terminator: "")
                template = readLine() ?? ""
                if template.isEmpty {
                    return
                }
                
                findAndPrintMathingWords(templateWord: template)
            }
        }
    }

}
