//
//  CardsCollectionView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/22.
//

import UIKit

final class CardListCollectionView: UICollectionView {
//    let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        collectionViewLayout = createLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createLayout() -> UICollectionViewLayout {
       let config = UICollectionViewCompositionalLayoutConfiguration()
       let layout = createCompositionalLayout()
       layout.configuration = config
       return layout
   }
   func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       return UICollectionViewCompositionalLayout { (sectionIndex, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.5))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item] )
           let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .estimated(16), heightDimension: .estimated(44))
           let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind:"section-header-element-kind", alignment: .top)

           sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
           let section = NSCollectionLayoutSection(group: group)
           section.boundarySupplementaryItems = [sectionHeader]
           section.interGroupSpacing = 8
           section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
           return section
       }
   }
    
}
