//
//  CharactersVC+CollectionView.swift
//  MarvelCharacters
//
//  Created by Tomás Fernández Velazco on 15/06/2021.
//

import UIKit

//MARK: CollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: BillboardCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: BillboardCollectionViewCell.nameOfClass)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCharactersCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 5
        let spacing: Float = 10.0
            
        let totalSpacing = (2 * CGFloat(spacing)) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
            
        if let collection = self.collectionView {
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
            
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillboardCollectionViewCell.nameOfClass, for: indexPath) as! BillboardCollectionViewCell
       
        viewModel.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetails(index: indexPath.row)
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((collectionView.contentOffset.y + collectionView.frame.size.height) > collectionView.contentSize.height ) && !viewModel.isLoading){
            viewModel.isLoading = true
            viewModel.loadMoreItemsForList()
        }
    }
}
