//
//  BillboardCollectionView.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import UIKit
import SDWebImage

class BillboardCollectionViewCell: UICollectionViewCell, CharacterCellView {
 
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var posterCharacterImage: ChachedImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func displayCharacter(title: String, posterImgUrl: String) {
        nameCharacter.text = title
        posterCharacterImage.sd_setImage(with: URL(string: posterImgUrl), placeholderImage: UIImage(named: "placeholder"))
    }
    
}
