//
//  CompositionalLayout1ViewModel.swift
//  CollectionViewLayoutsPractice
//
//  Created by Yaroslav Zhurbilo on 04.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CompositionalLayout1ViewModel {

    var disposeBag = DisposeBag()
    let dataSource: Driver<[Section]>
    private let currentSections: BehaviorRelay<[Section]>
    
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<Section>

    init() {
        self.currentSections = BehaviorRelay(value: [])

        let sectionAdaptersRaw: [Section] = [
            Section(
                section: Section1(sectionTitleData: "1"),
                items: [
                    ConfirmationRequiredCellAdapter()
                ]
            ),
            Section(
                section: Section2(sectionTitleData: "2"),
                items: [
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                    CauseCellAdapter(),
                ]
            ),
            Section(
                section: SpacingSectionAdapter(height: 16),
                items: [SpacingCellAdapter()]
            ),
            Section(
                section: Section3(sectionTitleData: "1"),
                items: [
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                    ItemCellAdapter(),
                ]
            ),
        ]

        Observable
            .just(sectionAdaptersRaw)
            .bind(to: self.currentSections)
            .disposed(by: disposeBag)
        
        dataSource = currentSections.asDriver()
    }

    func getSectionFor(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        currentSections.value[section].section
            .getSectionFor(index: section, environment: environment)
    }
}

extension CompositionalLayout1ViewModel {
    struct Section: SectionModelType {
        let section: SectionAdapterProtocol
        let items: [CellAdapterProtocol]
        
        init(section: SectionAdapterProtocol, items: [CellAdapterProtocol]) {
            self.section = section
            self.items = items
        }
        
        init(original: Section, items: [CellAdapterProtocol]) {
            self.section = original.section
            self.items = items
        }
    }
}
