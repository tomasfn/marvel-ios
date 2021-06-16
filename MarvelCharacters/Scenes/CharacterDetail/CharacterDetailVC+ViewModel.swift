//
//  CharacterDetailVC+ViewModel.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation
import SDWebImage

extension CharacterDetailViewController: CharacterDetailView {
    
    func startLoading() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func finishLoading() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func showError(error: String) {
        showAlertDialog(title: "error", message: error)
    }
    
    func showWebView(url: String, title: String) {
        let webVC = NavigationHelper.webViewController()
        webVC.url = url
        webVC.titleWeb = title
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func setInfo(imagePath: String) {
        backDropImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
    }
}
