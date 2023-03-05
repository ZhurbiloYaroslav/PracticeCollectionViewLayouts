//
//  SectionItemsAdapter.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import UIKit

struct SectionItemsAdapter: SectionAdapterProtocol {
    typealias HeaderViewType = ItemHeaderView
    private let headerViewKind = "ItemHeaderView"
    private let backgroundViewKind = "background2"
    
    func register(collectionView: UICollectionView?, layout: UICollectionViewCompositionalLayout?) {
        layout?.register(
            BackgroundView.self,
            forDecorationViewOfKind: backgroundViewKind
        )
        collectionView?.register(
            HeaderViewType.self,
            forSupplementaryViewOfKind: headerViewKind,
            withReuseIdentifier: HeaderViewType.reuseIdentifier
        )
    }

    func getSectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        /// Here we have a configguration for the third section/group/cells
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .flexible(0),
            top: nil,
            trailing: nil,
            bottom: nil
        )
        let footerHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: headerViewKind,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        let background = NSCollectionLayoutDecorationItem.background(elementKind: backgroundViewKind)
        let section = NSCollectionLayoutSection(group: group)
        section.decorationItems = [background]
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func getSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderViewType.reuseIdentifier,
            for: indexPath
        )
    }
}
