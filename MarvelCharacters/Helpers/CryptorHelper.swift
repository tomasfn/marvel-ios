//
//  EncryptorHelper.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation
import CryptoKit

class CryptoHelper {
    class func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
