//
//  CauseHeaderView.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 05.03.2023.
//

import SnapKit
import UIKit

class CauseHeaderView: UICollectionReusableView {
    
    private let titleLabel = UILabel().then {
        $0.text = "Cause"
        $0.textColor = .gray
    }
    
    static let reuseIdentifier = String(describing: CauseHeaderView.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(titleLabel)
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(8)
        }
    }
}
