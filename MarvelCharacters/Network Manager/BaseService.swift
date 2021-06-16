//
//  BaseService.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation
import Moya

enum BaseService {
    case getCharacters
    case getCharacter(id: String)
}

extension BaseService: TargetType {
        
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/public")!
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/characters"
        case .getCharacter(id: let id):
            return "/characters/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        //For unit testing
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .getCharacters:
            return .requestParameters(parameters: [ "apikey": SharedInfo.publicApiKey, "hash": SharedInfo.createHash(), "ts": SharedInfo.ts], encoding: URLEncoding.queryString)
        case .getCharacter(id: let _):
            return .requestParameters(parameters: [ "apikey": SharedInfo.publicApiKey, "hash": SharedInfo.createHash(), "ts": SharedInfo.ts], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
}
