//
//  ConfirmationRequiredCellAdapter.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import UIKit

struct ConfirmationRequiredCellAdapter: CellAdapterProtocol {
    typealias CellType = ConfirmationRequiredCell
    private let reuseIdentifier = String(describing: CellType.self)
    
    func register(collectionView: UICollectionView) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func getCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        register(collectionView: collectionView)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}
