//
//  CharacterDetailVC+TableView.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import UIKit
import Foundation

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailTableViewCell.nameOfClass, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.nameOfClass)
        addHeaderIfDescriptionExists()
    }
    
    func addHeaderIfDescriptionExists() {
        if let description = viewModel.selectedCharacter?.description {
            let descriptionLbl = EdgeInsetLabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: CGFloat.greatestFiniteMagnitude))
            descriptionLbl.textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            descriptionLbl.font = UIFont.systemFont(ofSize: 18)
            descriptionLbl.backgroundColor = .clear
            descriptionLbl.textColor = .systemGray
            descriptionLbl.text = description
            descriptionLbl.numberOfLines = 0
            descriptionLbl.sizeToFit()
            tableView.tableHeaderView = descriptionLbl
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.nameOfClass, for: indexPath) as? DetailTableViewCell {
            viewModel.configure(cell: cell, for: indexPath)
            
            return cell
        }
       return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let item = viewModel.didSelectRow(indexPath: indexPath)
        //viewModel.showLink(item: item)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 85))
        headerLbl.font = UIFont.systemFont(ofSize: 20)
        headerLbl.backgroundColor = .lightGray
        headerLbl.textColor = .white
        headerLbl.text = viewModel.setTitleForSection(section: section)
        headerLbl.textAlignment = .center
        
        return headerLbl
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((tableView.contentOffset.y + tableView.frame.size.height) > tableView.contentSize.height ) && !viewModel.isLoading){
            viewModel.isLoading = true
            viewModel.fetchDataOfSelectedCharacter()
        }
    }
}


