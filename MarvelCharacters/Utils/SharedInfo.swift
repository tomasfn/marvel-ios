//
//  SharedInfo.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation
import CryptoKit

enum SharedInfo {
        
    //BaseURL
    static let baseUrl = "https://gateway.marvel.com:443/v1/public"
        
    //API Key
    static let publicApiKey = "8401a40c68ece0b7658ef2f5c776c6b9"
    static let privateApiKey = "065255b842f1208c9d9e2ec8725b0ba922c9a0de"
    static let ts = "1"
    
    func timeStap() -> String {
        let date = Date().currentTimeMillis()
        return "\(date)"
    }
    
    static func createHash() -> String {
        let encrypt = SharedInfo.ts + SharedInfo.privateApiKey + SharedInfo.publicApiKey
        return CryptoHelper.MD5(string: encrypt)
    }
    
}

