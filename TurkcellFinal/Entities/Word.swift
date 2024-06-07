//
//  Words.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import Foundation

// MARK: - WordElement
struct WordResult: Decodable {
    let word: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let license: License?
    let sourceUrls: [String]?
}

// MARK: - License
struct License: Decodable {
    let name: String?
    let url: String?
}

// MARK: - Meaning
struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    let synonyms, antonyms: [String]?
}

// MARK: - Definition
struct Definition: Decodable {
    let definition: String?
    let synonyms, antonyms: [String]?
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Decodable {
    let audio: String?
    let sourceURL: String?
    let license: License?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case audio
        case sourceURL = "sourceUrl"
        case license, text
    }
}



struct ErrorResponse: Decodable {
    let title: String?
    let message: String?
    let resolution: String?
}
