//
//  SingleLineCollectionView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/23.
//

import UIKit

final class SingleLineCollectionView: UICollectionView {

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
        config.scrollDirection = .horizontal
       layout.configuration = config
       return layout
   }
   func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       return UICollectionViewCompositionalLayout { (sectionIndex, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.33))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item] )
           let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .estimated(16), heightDimension: .estimated(44))
           let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind:"section-header-element-kind", alignment: .top)

           sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
           let section = NSCollectionLayoutSection(group: group)
           section.boundarySupplementaryItems = [sectionHeader]
//           section.interGroupSpacing = 8
           section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
           return section
       }
   }
    
}
