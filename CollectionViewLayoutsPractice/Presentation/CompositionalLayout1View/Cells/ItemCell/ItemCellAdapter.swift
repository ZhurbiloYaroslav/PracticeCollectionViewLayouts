//
//  ItemCellAdapter.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import UIKit

struct ItemCellAdapter: CellAdapterProtocol {
    typealias CellType = ItemCell
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
