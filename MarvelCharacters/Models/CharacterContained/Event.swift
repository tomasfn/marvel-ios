//
//  Event.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation

struct Event: Codable {
    let available: Int
    let collectionURI: String
    let items: [Item]
    let returned: Int
}

