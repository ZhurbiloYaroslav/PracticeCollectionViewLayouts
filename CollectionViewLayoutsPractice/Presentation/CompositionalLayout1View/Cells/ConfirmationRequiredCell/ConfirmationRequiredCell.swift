//
//  ConfirmationRequiredCell.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import SnapKit
import Then
import UIKit

class ConfirmationRequiredCell: UICollectionViewCell {
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [
            titleLable,
            subtitleLabel
        ]).then {
            $0.axis = .vertical
            $0.spacing = 8
        }
    
    private let titleLable = UILabel().then {
        $0.text = "Confirmation required"
        $0.textColor = .red
        $0.numberOfLines = 1
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "We need to confirm something"
        + "We need to confirm something"
        + "We need to confirm something"
        + "We need to confirm something"
        $0.textColor = .gray
        $0.numberOfLines = 0
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
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
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(8)
        }
    }
    
    func bind(viewModel: String) {
        // TODO: Implement it
    }
}
