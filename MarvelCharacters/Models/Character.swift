//
//  Character.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: Comic?
    let series: Serie?
    let stories: Story?
    let events: Event?
    let urls: [URLCustom]?
}

struct CharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct CharacterResult: Codable {
    var data: CharacterData
}

