//
//  FlowLayoutLifecycleViewLayout.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 08.03.2023.
//

import UIKit

class FlowLayoutLifecycleViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        return context
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private var attribute: UICollectionViewLayoutAttributes?
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

        // Helpers
        let sectionsToAdd = NSMutableIndexSet()
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for layoutAttributesSet in layoutAttributes {
            if layoutAttributesSet.representedElementCategory == .cell {
                // Add Layout Attributes
                newLayoutAttributes.append(layoutAttributesSet)

                // Update Sections to Add
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)

            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
                // Update Sections to Add
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }

        for section in sectionsToAdd {
            let indexPath = IndexPath(item: 0, section: section)

            if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
                newLayoutAttributes.append(sectionAttributes)
            }
        }

        return newLayoutAttributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) ?? attribute else { return nil }
        guard let boundaries = boundaries(forSection: indexPath.section) else { return layoutAttributes }
        guard let collectionView = collectionView else { return layoutAttributes }

        // Helpers
        let contentOffsetY = collectionView.contentOffset.y
        var frameForSupplementaryView = layoutAttributes.frame

        let minimum = boundaries.minimum
        let maximum = boundaries.maximum

        if contentOffsetY < minimum {
            frameForSupplementaryView.origin.y = minimum
        } else if contentOffsetY > maximum {
            frameForSupplementaryView.origin.y = maximum
        } else {
            frameForSupplementaryView.origin.y = contentOffsetY
        }

        layoutAttributes.frame = frameForSupplementaryView

        return layoutAttributes
    }
    
    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
        // Helpers
        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))

        // Exit Early
        guard let collectionView = collectionView else { return result }

        // Fetch Number of Items for Section
        let numberOfItems = collectionView.numberOfItems(inSection: section)

        // Exit Early
        guard numberOfItems > 0 else { return result }

        if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
           let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
            result.minimum = firstItem.frame.minY
            result.maximum = lastItem.frame.maxY

            // Take Header Size Into Account
            result.minimum -= headerReferenceSize.height
            result.maximum -= headerReferenceSize.height

            // Take Section Inset Into Account
            result.minimum -= sectionInset.top
            result.maximum += (sectionInset.top + sectionInset.bottom)
        }

        return result
    }
}

class CollectionViewLayoutInvalidationContext: UICollectionViewFlowLayoutInvalidationContext {
    override var invalidateEverything: Bool { false }
    
    private var _invalidatedItemIndexPaths: [IndexPath] = []
    override var invalidatedItemIndexPaths: [IndexPath]? {
        _invalidatedItemIndexPaths
    }
    
    override func invalidateItems(at indexPaths: [IndexPath]) {
        _invalidatedItemIndexPaths = indexPaths
    }
}
