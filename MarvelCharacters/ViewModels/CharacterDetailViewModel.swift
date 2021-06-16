//
//  CharacterDetailViewModel.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import Foundation


protocol CharacterDetailCellView {
    func displayInfo(info: String, subTitleInfo: String)
}

protocol CharacterDetailView: class {
    func startLoading()
    func finishLoading()
    func setInfo(imagePath: String)
    func showWebView(url: String, title: String)
    func showError(error: String)
}

class CharacterDetailViewModel {
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
    
    var selectedCharacter: Character?
    
    private weak var view: CharacterDetailView?
    
    var apiService: APIServiceProtocol
    
    func setView(view: CharacterDetailView) {
        self.view = view
    }
    
    init(selectedCharacter: Character, apiService: APIServiceProtocol = NetworkService()) {
        self.selectedCharacter = selectedCharacter
        self.apiService = apiService
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    func fetchDataOfSelectedCharacter() {
        self.isLoading = true
        
        self.view?.startLoading()
        
        guard let id = selectedCharacter?.id else {return}
        apiService.getCharacter(id: "\(String(describing: id))"){ [weak self] (character, error) in
            guard let self = self else { return }
            self.view?.finishLoading()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let character = character else { return }
                self.selectedCharacter = character
                self.view?.finishLoading()
            }
        }
    }
    
    func getEventsItems() -> [Item] {
        var eventsItems = [Item]()
        if let items = selectedCharacter?.events?.items {
            eventsItems.append(contentsOf: items)
        }
        return eventsItems
    }
    
    func getStoriesItems() -> [Item] {
        var storyItems = [Item]()
        if let items = selectedCharacter?.stories?.items {
            storyItems.append(contentsOf: items)
        }
        return storyItems
    }
    
    func getComicsItems() -> [Item] {
        var comicsItems = [Item]()
        if let items = selectedCharacter?.comics?.items {
            comicsItems.append(contentsOf: items)
        }
        return comicsItems
    }
    
    func getSeriesItems() -> [Item] {
        var seriesItems = [Item]()
        if let items = selectedCharacter?.series?.items {
            seriesItems.append(contentsOf: items)
        }
        return seriesItems
    }
                    
    func configure(cell: CharacterDetailCellView, for indexPath: IndexPath) {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let info = getEventsItems()[indexPath.row]
            cell.displayInfo(info: info.name, subTitleInfo: info.resourceURI)
        case 1:
            let info = getComicsItems()[indexPath.row]
            cell.displayInfo(info: info.name, subTitleInfo: info.resourceURI)
        case 2:
            let info = getSeriesItems()[indexPath.row]
            cell.displayInfo(info: info.name, subTitleInfo: info.resourceURI)
        case 3:
            let info = getStoriesItems()[indexPath.row]
            cell.displayInfo(info: info.name, subTitleInfo: info.resourceURI)
        default:
            break
        }
        
    }
    
    func formattedDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        return date
    }
    
    func finalDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let str = dateFormatter.string(from: date)
        return str
    }
        
    func setInfoDetail() {
        guard let path = selectedCharacter?.thumbnail?.path else {return}
        guard let fileExtension = selectedCharacter?.thumbnail?.extension else {return}

        view?.setInfo(imagePath: path + "." + fileExtension)
    }
    
    func numberOfSections() -> Int {
        
        var qty = 0
        
        if (selectedCharacter?.stories) != nil {
            qty = qty + 1
        }
        
        if (selectedCharacter?.events) != nil {
            qty = qty + 1
        }
        
        if (selectedCharacter?.comics) != nil {
            qty = qty + 1
        }
        
        if (selectedCharacter?.series) != nil {
            qty = qty + 1
        }
        
        if (selectedCharacter?.urls) != nil {
            qty = qty + 1
        }
        
        return qty
    }
    
    func numbersOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return getEventsItems().count
        case 1:
            return getComicsItems().count
        case 2:
            return getSeriesItems().count
        case 3:
            return getStoriesItems().count
        default:
            return Int()
        }
    }
    
    func didSelectRow(indexPath: IndexPath) -> Item {
        
        var selectedItem: Item! = nil
        switch indexPath.section {
        case 0:
            let item = getEventsItems()[indexPath.row]
            selectedItem = Item(resourceURI: item.resourceURI, name: item.name, type: item.type ?? "")
        case 1:
            let item = getComicsItems()[indexPath.row]
            selectedItem = Item(resourceURI: item.resourceURI, name: item.name, type: item.type ?? "")
        case 2:
            let item = getSeriesItems()[indexPath.row]
            selectedItem = Item(resourceURI: item.resourceURI, name: item.name, type: item.type ?? "")
        case 3:
            let item = getStoriesItems()[indexPath.row]
            selectedItem = Item(resourceURI: item.resourceURI, name: item.name, type: item.type ?? "")
        default:
            break
        }
        
        return selectedItem
    }
    
    func setTitleForSection(section: Int) -> String {
        
        var title = ""
        
        switch section {
        case 0:
            title = "Events"
        case 1:
            title = "Comics"
        case 2:
            title = "Series"
        case 3:
            title = "Stories"
        default:
            break
        }
        
        return title
    }
    
    func showLink(item: Item) {
        view?.showWebView(url: item.resourceURI, title: item.name)
    }
}
