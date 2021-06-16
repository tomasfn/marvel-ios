//
//  CharactersVC+ViewModel.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation

extension CharactersViewController: CharacterView {
    
    func showCharacterDetails(viewModel: CharacterDetailViewModel) {
        let vc = CharacterDetailViewController.`init`(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
    
}
