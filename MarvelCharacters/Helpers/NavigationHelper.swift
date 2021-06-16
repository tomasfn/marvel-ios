//
//  NavigationHelper.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation
import UIKit

class NavigationHelper {
    
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

    class func charactersViewController() -> CharactersViewController {
        let charactersVc = mainStoryboard.instantiateViewController(withIdentifier: CharactersViewController.nameOfClass) as! CharactersViewController
        return charactersVc
    }
    
    class func characterDetailViewController() -> CharacterDetailViewController {
        let characterDetailVc = mainStoryboard.instantiateViewController(withIdentifier: CharacterDetailViewController.nameOfClass) as! CharacterDetailViewController
        return characterDetailVc
    }
    
    class func webViewController() -> WebViewController {
        let webVc = mainStoryboard.instantiateViewController(withIdentifier: WebViewController.nameOfClass) as! WebViewController
        return webVc
    }
}
