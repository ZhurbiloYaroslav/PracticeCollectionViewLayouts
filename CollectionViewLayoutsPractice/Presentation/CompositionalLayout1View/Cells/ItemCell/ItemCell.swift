//
//  ItemCell.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import SnapKit
import Then
import UIKit

class ItemCell: UICollectionViewCell {
    
    private lazy var stackView = ItemCellHeaderContainer(
        col1: titleLabelCode,
        col2: titleLabelName,
        col3: titleLabelColor,
        col4: titleLabelSize,
        col5: titleLabelQty
    )
    
    private let titleLabelCode = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private let titleLabelName = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 5
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    private let titleLabelColor = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private let titleLabelSize = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private let titleLabelQty = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
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
        contentView.addSubview(stackView)
        backgroundColor = .white
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(8)
        }
    }
    
    func bind(viewModel: ItemCellModel) {
        titleLabelCode.text = viewModel.code
        titleLabelName.text = viewModel.name
        titleLabelColor.text = viewModel.color
        titleLabelSize.text = viewModel.size
        titleLabelQty.text = viewModel.quantity
    }
}

struct ItemCellModel {
    let code: String
    let name: String
    let color: String
    let size: String
    let quantity: String
}

class ItemCellHeaderContainer: UIStackView {
    
    let col1: UIView
    let col2: UIView
    let col3: UIView
    let col4: UIView
    let col5: UIView
    
    init(col1: UIView,
         col2: UIView,
         col3: UIView,
         col4: UIView,
         col5: UIView
    ) {
        self.col1 = col1
        self.col2 = col2
        self.col3 = col3
        self.col4 = col4
        self.col5 = col5
        super.init(frame: .zero)
        configureViews()
        setupConstrains()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        axis = .horizontal
        alignment = .center
        spacing = 8
        addArrangedSubview(col1)
        addArrangedSubview(col2)
        addArrangedSubview(col3)
        addArrangedSubview(col4)
        addArrangedSubview(col5)
    }
    
    func setupConstrains() {
        col1.snp.makeConstraints { maker in
            maker.width.equalTo(50)
            maker.width.equalTo(col3)
            maker.width.equalTo(col4)
            maker.width.equalTo(col5)
        }
    }
}
