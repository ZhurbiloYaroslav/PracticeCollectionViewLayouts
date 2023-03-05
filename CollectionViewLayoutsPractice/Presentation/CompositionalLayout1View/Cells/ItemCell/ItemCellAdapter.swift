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
    let viewModel: ItemCellModel
    
    func register(collectionView: UICollectionView) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func getCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        register(collectionView: collectionView)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? CellType {
            cell.bind(viewModel: viewModel)
        }
        return cell
    }
}
