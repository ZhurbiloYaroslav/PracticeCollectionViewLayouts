//
//  ViewController.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit
import RxDataSources

class CompositionalLayout1View: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: CompositionalLayout1ViewModel?
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.backgroundColor = .lightGray
    }
    
    private lazy var collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment -> NSCollectionLayoutSection? in
        self?.viewModel?.getSectionFor(section: sectionIndex, environment: environment)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        setupConstraints()
    }
    
    func configureViews() {
        view.backgroundColor = .blue
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

    func bindViewModel() {
        let viewModel = CompositionalLayout1ViewModel()
        self.viewModel = viewModel
        let dataSource = CompositionalLayout1ViewModel.DataSource(configureCell: { sections, collectionView, indexPath, cellAdapter in
            cellAdapter.getCell(indexPath: indexPath, collectionView: collectionView)
        }, configureSupplementaryView: { result, collectionView, viewOfKind, indexPath in
            result[indexPath.section].section.getSupplementaryView(collectionView: collectionView, kind: viewOfKind, indexPath: indexPath)
            ?? collectionView.dequeueReusableSupplementaryView(ofKind: viewOfKind, withReuseIdentifier: "Empty", for: indexPath)
        })
        viewModel.dataSource
            .do(onNext: { [weak self] sections in
                sections.forEach { $0.section.register(collectionView: self?.collectionView, layout: self?.collectionViewLayout)}
            })
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

protocol SectionAdapterProtocol {
    func register(collectionView: UICollectionView?, layout: UICollectionViewCompositionalLayout?)
    func getSectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
    func getSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView?
}

protocol CellAdapterProtocol {
    func getCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell
}

class FirstCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
