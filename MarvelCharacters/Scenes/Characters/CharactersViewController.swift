//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
        
    lazy var viewModel: CharactersListViewModel = {
          return CharactersListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        initViewModel()
        setUpCollectionView()
    }
    
    func initViewModel() {
        viewModel.setView(view: self)
        viewModel.reloadTableViewClosure = { [weak self] () in
           DispatchQueue.main.async {
              self?.collectionView.reloadData()
           }
        }
        
        viewModel.fetchData()
    }
}

