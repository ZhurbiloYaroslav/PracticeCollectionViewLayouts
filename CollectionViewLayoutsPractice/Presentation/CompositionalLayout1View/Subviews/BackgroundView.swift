//
//  BackgroundView.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import UIKit

class BackgroundView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension BackgroundView {
    func configure() {
        backgroundColor = UIColor.white.withAlphaComponent(1)
        layer.borderWidth = 0
        layer.cornerRadius = 12
    }
}
