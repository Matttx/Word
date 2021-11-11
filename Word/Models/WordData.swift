//
//  WordData.swift
//  Word
//
//  Created by Matteo on 10/11/2021.
//

import Foundation

struct Details: Codable {
    let definition: String
    let partOfSpeech: String
    let synonyms: [String]?
    let examples: [String]?
}
