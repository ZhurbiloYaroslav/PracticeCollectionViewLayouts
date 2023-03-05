//
//  ItemHeaderView.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import SnapKit
import UIKit

class ItemHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: ItemHeaderView.self)
    
    private lazy var stackView = ItemCellHeaderContainer(
        col1: titleLabel1,
        col2: titleLabel2,
        col3: titleLabel3,
        col4: titleLabel4,
        col5: titleLabel5
    )
    
    private let titleLabel1 = UILabel().then {
        $0.text = "Item\nCode"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let titleLabel2 = UILabel().then {
        $0.text = "Item"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let titleLabel3 = UILabel().then {
        $0.text = "Color"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let titleLabel4 = UILabel().then {
        $0.text = "Size"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let titleLabel5 = UILabel().then {
        $0.text = "Qty."
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        addSubview(stackView)
        backgroundColor = .white
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(8)
        }
    }

}
