//
//  CharactersListViewModel.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation

protocol CharacterCellView {
    func displayCharacter(title: String, posterImgUrl: String)
}

protocol CharacterView: class {
    func startLoading()
    func finishLoading()
    func showCharacterDetails(viewModel: CharacterDetailViewModel)
    func showError(error: String)
}

class CharactersListViewModel {
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
      
    let apiService: APIServiceProtocol
        
    private weak var view: CharacterView?

    var characters: [Character] = [Character]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    func setView(view: CharacterView) {
        self.view = view
    }
        
    var currentPage : Int = 0
    var totalPages : Int = 0
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }

    init(apiService: APIServiceProtocol = NetworkService()) {
        self.apiService = apiService
    }
    
    func fetchData() {
    self.isLoading = true
        
        self.view?.startLoading()
        
        apiService.getCharacters { [weak self] (characters, error) in
            guard let self = self else { return }
            self.view?.finishLoading()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let characters = characters else { return }
                self.characters = characters
                self.view?.finishLoading()
            }
        }
  }
    
    func loadMoreItemsForList(){
        currentPage += 1
        fetchData()
    }
  
    func configure(cell: CharacterCellView, for index: Int) {
        let character = characters[index]
        
        guard let name = character.name else {return}
        guard let imageUrl = character.thumbnail?.path else {return}
        guard let fileExtension = character.thumbnail?.extension else {return}
        
        cell.displayCharacter(title: name, posterImgUrl: imageUrl + "." + fileExtension)
    }
    
    func showDetails(index: Int) {
        let character = characters[index]
        let detailViewModel = CharacterDetailViewModel(selectedCharacter: character)
        view?.showCharacterDetails(viewModel: detailViewModel)
    }
        
    func getCharactersCount() -> Int {
        return characters.count
    }
}


