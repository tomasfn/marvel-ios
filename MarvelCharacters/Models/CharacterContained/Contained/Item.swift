//
//  Item.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 16/06/2021.
//

import Foundation

struct Item: Codable {
    let resourceURI: String
    let name: String
    let type: String?
    
    init(resourceURI: String, name: String, type: String) {
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
    }
}



