//
//  NetworkService.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation
import Moya

protocol APIServiceProtocol: AnyObject {
    func getCharacters(completion: @escaping ([Character]?, Error?)->Void)
    func getCharacter(id: String, completion: @escaping (Character?, Error?)->Void)
}

class NetworkService: APIServiceProtocol {
    
    let baseProvider = MoyaProvider<BaseService>()
    
    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
        baseProvider.request(.getCharacters) { (result) in
            switch result {
            case let .success(response):
                            
                do {
                     let decoder = JSONDecoder()
                    let result = try decoder.decode(CharacterResult.self, from: response.data)
                    let characters = result.data.results
                    completion(characters, nil)
                    
                } catch let error {
                    // Status code error or Mapping Error
                    print(error)
                    completion(nil, error)
                }
     
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getCharacter(id: String, completion: @escaping (Character?, Error?) -> Void) {
        baseProvider.request(.getCharacter(id: id)) { (result) in
            switch result {
            case let .success(response):
                            
                do {
                     let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(CharacterResult.self, from: response.data)
                    let character = result.data.results.first

                    completion(character, nil)
                    
                } catch let error {
                    // Status code error or Mapping Error
                    print(error)
                    completion(nil, error)
                }
     
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
