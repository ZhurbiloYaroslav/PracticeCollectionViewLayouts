//
//  CauseCell.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import SnapKit
import Then
import UIKit

class CauseCell: UICollectionViewCell {
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [
            roundView,
            titleLable
        ]).then {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
    
    private let roundView = UIView().then {
        $0.layer.borderColor = UIColor.blue.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let titleLable = UILabel().then {
        $0.text = "Cause"
        $0.textColor = .black
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
    }
    
    func setupConstraints() {
        roundView.snp.makeConstraints { maker in
            maker.width.height.equalTo(20)
        }
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(8)
        }
    }
    
    func bind(viewModel: String) {
        // TODO: Implement it
    }
}
