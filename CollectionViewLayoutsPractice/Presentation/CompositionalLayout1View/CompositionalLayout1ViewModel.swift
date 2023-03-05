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
                section: SectionConfirmAdapter(),
                items: [
                    ConfirmationRequiredCellAdapter()
                ]
            ),
            Section(
                section: SectionCauseAdapter(sectionHeader: "Cause"),
                items: (0...15).reduce(into: [CauseCellAdapter](), { partialResult, number in
                    partialResult.append(CauseCellAdapter(title: "Cause \(number)"))
                })
            ),
            Section(
                section: SectionSpacingAdapter(height: 16),
                items: [SpacingCellAdapter()]
            ),
            Section(
                section: SectionItemsAdapter(),
                items: (0...200).reduce(into: [CauseCellAdapter](), { partialResult, number in
                    let viewModel = ItemCellModel(
                        code: String(describing: Int.random(in: (0...999))),
                        name: .random(of: 200),
                        color: "99",
                        size: "99",
                        quantity: "99"
                     )
                    partialResult.append(ItemCellAdapter(viewModel: viewModel))
                })
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

extension String {
   static func random(of n: Int) -> String {
      let digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 "
      return String(Array(0..<n).map { _ in digits.randomElement()! })
   }
}
