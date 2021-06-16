//
//  DetailTableViewCell.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import UIKit
import Foundation

class DetailTableViewCell: UITableViewCell, CharacterDetailCellView {
    
    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var collectionView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayInfo(info: String, subTitleInfo: String) {
        titleInfoLabel.text = info
    }    
}
