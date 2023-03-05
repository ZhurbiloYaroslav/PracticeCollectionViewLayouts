//
//  SpacingCellAdapter.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import UIKit

struct SpacingCellAdapter: CellAdapterProtocol {
    typealias CellType = UICollectionViewCell
    private let reuseIdentifier = "EmptySpacerView"
    
    func register(collectionView: UICollectionView) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func getCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        register(collectionView: collectionView)
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
}
