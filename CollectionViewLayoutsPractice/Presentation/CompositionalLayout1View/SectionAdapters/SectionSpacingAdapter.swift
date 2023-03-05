//
//  SectionSpacingAdapter.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import UIKit

struct SectionSpacingAdapter: SectionAdapterProtocol {

    let height: CGFloat
    
    func register(collectionView: UICollectionView?, layout: UICollectionViewCompositionalLayout?) {
        // Do nothing for now
    }
    
    func getSectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func getSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        nil
    }
}
