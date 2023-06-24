//
//  CardPickerViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/08.
//

import UIKit
import RealmSwift

final class CardPickerViewContoller: BaseViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    private let mainView = CardPickerView()
    private let deck: Deck
    private var cards: [Card] = [] {
        didSet {
            makeSnapShot(items: cards, dataSource: dataSource)
        }
    }
    private var selectedCards:[Card] = []
    private var plusCard = Card(question: "새카드 만들기")
    
    init(deck: Deck) {
        self.deck = deck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        configureDataSource()
        fetchCards()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCards()
        updateSection()
    }
    
    override func configure() {
        super.configure()
        mainView.listView.collectionView.delegate = self
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    
    private func fetchCards() {
        let result = self.repository.fetch(model: Card.self)
        self.cards = Array(result)
     
    }
    private func addNewCard() {
        var snapShot = dataSource.snapshot()
        snapShot.appendItems([plusCard], toSection: 0)
        dataSource.apply(snapShot)
    }
    override func makeSnapShot<T>(items: [T], dataSource: UICollectionViewDiffableDataSource<Int, T>) where T : Hashable {
        super.makeSnapShot(items: items, dataSource: dataSource)
        addNewCard()
    }
    private func updateSection() {
        var snapshot = dataSource.snapshot()
        snapshot.reloadSections([0])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    @objc private func addButtonClicked() {
      
        repository.appendCardToDeck(cards: selectedCards, deck: deck)
        refreshRootViewWillAppear(rootVC: DeckDetailViewController.self)
        dismiss(animated: true)
    }
    @objc private func cellButtonPressed(sender: UIButton) {
      
        transition(CardViewController(card: cards[sender.tag]), transitionStyle: .presentOverFull)
    }
}

//MARK: CollectionView datasource
extension CardPickerViewContoller {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CollectionViewBaseCell, Card>.init {[weak self] cell,indexPath,itemIdentifier in
            guard let self else {return}
            cell.titleLabel.text = itemIdentifier.question
            if indexPath.item == self.cards.count {
                cell.centerView.backgroundColor = .systemGray5
                cell.button.isHidden = true
            } else {
                if self.deck.cards.contains(itemIdentifier) { //이미 사용중인 카드
                    cell.contentView.alpha = 0.4
//                    cell.isUserInteractionEnabled = false
                }
                cell.button.addTarget(self, action: #selector(self.cellButtonPressed), for: .touchUpInside)
                cell.button.tag = indexPath.item
            }
        }
        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.listView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }

}

extension CardPickerViewContoller: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewBaseCell else { return }
        guard indexPath.item < cards.count else { //새카드 만들기
            transition(CardViewController(card: nil), transitionStyle: .presentOverFull)
            return }
        let selected = cards[indexPath.item]
        guard !deck.cards.contains(selected) else {
            mainView.makeToast("이 덱에서 이미 사용중인 카드입니다.")
            return} //이미 덱에 있는 카드
        
        if selectedCards.contains(selected) {
            if let index = selectedCards.firstIndex(of: selected) {
                selectedCards.remove(at: index)
                cell.centerView.backgroundColor = .systemGroupedBackground
            }
        } else {
            selectedCards.append(selected)
            cell.centerView.backgroundColor = .systemGray3
        }
    }
}
