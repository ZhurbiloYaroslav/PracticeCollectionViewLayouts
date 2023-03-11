//
//  FlowLayoutLifecycle.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 08.03.2023.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit
import RxDataSources

class FlowLayoutLifecycleView: UIViewController {
    
    private let disposeBag = DisposeBag()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.dataSource = self
        $0.backgroundColor = .lightGray
        $0.register(FlowLayoutLifecycleCell.self, forCellWithReuseIdentifier: FlowLayoutLifecycleCell.reuseIdentifier)
        $0.register(FlowLayoutLifecycleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FlowLayoutLifecycleHeader.reuseIdentifier)
    }
    
    private lazy var collectionViewLayout = FlowLayoutLifecycleViewLayout().then {
        $0.itemSize = .init(width: 50, height: 50)
        $0.estimatedItemSize = .init(width: 50, height: 50)
        $0.headerReferenceSize = .init(width: UIScreen.main.bounds.width, height: 50)
        $0.register(FlowLayoutLifecycleDecoration.self, forDecorationViewOfKind: FlowLayoutLifecycleDecoration.kindIdentifier)
        $0.sectionHeadersPinToVisibleBounds = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        setupConstraints()
    }
    
    func configureViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

}

extension FlowLayoutLifecycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: FlowLayoutLifecycleCell.reuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FlowLayoutLifecycleHeader.reuseIdentifier, for: indexPath)
        if indexPath.section == 0 {
            header.backgroundColor = .blue
        } else {
            header.backgroundColor = .green
        }
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
}

class FlowLayoutLifecycleCell: UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FlowLayoutLifecycleHeader: UICollectionReusableView {
    static var reuseIdentifier: String { String(describing: Self.self) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FlowLayoutLifecycleDecoration: UICollectionReusableView {
    static var kindIdentifier: String { "Background" }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
