//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImage: ChachedImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var viewModel: CharacterDetailViewModel!
    
    static func `init`(with viewModel: CharacterDetailViewModel) -> CharacterDetailViewController {
        let vc = NavigationHelper.characterDetailViewController()
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let characterName = viewModel.selectedCharacter?.name else { return }
        title = characterName
        
        setUpTable()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.setView(view: self)
        viewModel.setInfoDetail()
        finishLoading()
        viewModel.reloadTableViewClosure = { [weak self] () in
           DispatchQueue.main.async {
              self?.tableView.reloadData()
           }
        }
    }
}
