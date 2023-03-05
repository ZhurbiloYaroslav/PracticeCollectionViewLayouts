//
//  Section2Adapter.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import UIKit

struct Section2: SectionAdapterProtocol {
    typealias HeaderViewType = CauseHeaderView
    private let headerViewKind = "CauseHeaderView"
    private let backgroundViewKind = "background1"

    let sectionTitleData: String
    
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
        /// Here we have a configguration for the second section/group/cells
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0), top: nil, trailing: nil, bottom: nil)
        
        let footerHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50.0)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: headerViewKind,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        let background = NSCollectionLayoutDecorationItem.background(elementKind: backgroundViewKind)
        background.contentInsets = NSDirectionalEdgeInsets(top: 58, leading: 16, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.decorationItems = [background]
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
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
