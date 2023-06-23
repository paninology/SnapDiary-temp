//
//  WriteViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit


final class WriteViewController: BaseViewController {
    
    private let mainView = WriteView()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    private var deckCards: [Card]?
    private let book: Book
    
    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deckCards = book.deck == nil ? [] : Array(book.deck!.cards)
        makeSnapShot(items: deckCards ?? [], dataSource: dataSource)
    }
    
    override func configure() {
        super.configure()
        view = mainView
        mainView.dateLable.text = "date: 11231231231"
        mainView.questionLable.text = "오늘점심은?"
        
        mainView.collectionView.delegate = self
        configureDataSource()
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(savebuttonPressed), for: .touchUpInside)
    }
    @objc private func savebuttonPressed(sender: UIButton) {
         
    }
    
}
//MARK: CollectionView datasource
extension WriteViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "section-header-element-kind") { [weak self]
                   (supplementaryView, string, indexPath) in
            guard let self = self else {return}
               }
        let cellRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Card>.init { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else {return}
            cell.questionLabel.text = itemIdentifier.question
            
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.mainView.collectionView.dequeueConfiguredReusableSupplementary(
                        using: headerRegistration , for: index)
                }
    }
}

extension WriteViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }
   
}
