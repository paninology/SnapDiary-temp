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
    private var date = Date()
    private var selectedCard: Card?
    
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
        mainView.dateLable.text = "날짜 변경: "
        mainView.collectionView.delegate = self
        configureDataSource()
        mainView.titleLable.text = date.formatted(date: .abbreviated, time: .omitted)
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(savebuttonPressed), for: .touchUpInside)
        mainView.datepicker.addTarget(self, action: #selector(datepickerChanged), for: .valueChanged)
    }
    @objc private func datepickerChanged(sender: UIDatePicker) {
        date = sender.date
        mainView.titleLable.text = date.formatted(date: .abbreviated, time: .omitted)
    }
    @objc private func savebuttonPressed(sender: UIButton) {
        guard let selectedCard = selectedCard else {
            showAlertWithCompletion(title: "질문카드를 선택해주세요", message: "", hasCancelButton: false, completion: nil)
            return
        }
        guard let text = mainView.textView.text,
              text.trimmingCharacters(in: .whitespaces) != ""  else {
            showAlertWithCompletion(title: "일기 내용을 입력해주세요", message: "", hasCancelButton: false, completion: nil)
            return
        }
        let diary = Diary(text: mainView.textView.text, card: selectedCard, date: date)
        repository.addItem(items: diary)
        repository.appendDiaryToBook(diary: diary, book: book)
        refreshRootViewWillAppear(rootVC: BookViewController.self)
        dismiss(animated: true)
    }
    
}
//MARK: CollectionView datasource
extension WriteViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "section-header-element-kind") { [weak self]
                   (supplementaryView, string, indexPath) in
            guard let self = self else {return}
//            supplementaryView.label.text = "\(book.deck?.title)의 카드들"
               }
        let cellRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Card>.init { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else {return}
            cell.questionLabel.text = itemIdentifier.question
            cell.deleteButton.isHidden = true
            
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
        selectedCard = deckCards?[indexPath.item]
        mainView.questionLable.text = selectedCard?.question
        
    }
   
}
