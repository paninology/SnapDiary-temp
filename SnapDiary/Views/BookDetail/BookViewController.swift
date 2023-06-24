//
//  BookDetailViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/21.
//

import UIKit
//
final class BookViewController: BaseViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Diary>!
    private let mainView = BookView()
    let testCards = ["오늘 기분은?", "점심은 뭘 먹었나요?", "이번주에 남편이 가장 열받게 했을때는 언제인가요?이번주에 남편이 가장 열받게 했을때는 언제인가요?이번주에 남편이 가장 열받게 했을때는 언제인가요?이번주에 남편이 가장 열받게 했을때는 언제인가요?이번주에 남편이 가장 열받게 했을때는 언제인가요?"]
    let testBack = ["좋아요", "라면", "지금이순간~~~~~~~~~마법처럼~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~지금이순간지금이순간"]
//    private var questions
    private var diaries: [Diary]
    private let book: Book
    private var nowEditing = false
    
    init(book: Book) {
        self.book = book
        self.diaries = Array(book.diaries)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeSnapShot(items: diaries, dataSource: dataSource)
        
    }
    
    override func configure() {
        super.configure()
        view = mainView
        mainView.bookDetailView.title.text = book.title
        mainView.bookDetailView.subtitle.text = book.subtitle
        mainView.bookDetailView.deckInfo.text = "사용중인 덱:  " + (book.deck?.title ?? "없음")
        mainView.bookDetailView.notiOption.text = "알림:  " + (book.notiOption ?? "미설정") + book.notiDate.formatted(date: .omitted, time: .shortened)
        configureDataSource()
        mainView.collectionView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "새일기", style: .plain, target: self, action: #selector(newDiaryButtonPressed))
        
    }
    private func cellTapped(cell: DiaryCollectionViewCell) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        if cell.isFlipped {
            UIView.transition(from: cell.backView, to: cell.frontView, duration: 0.5, options: transitionOptions, completion: nil)
        } else {
            UIView.transition(from: cell.frontView, to: cell.backView, duration: 0.5, options: transitionOptions, completion: nil)
        }
        print(cell.isFlipped)
        cell.isFlipped.toggle()
    }
    @objc private func newDiaryButtonPressed(sender: UIButton) {
        transition(WriteViewController(book: book), transitionStyle: .presentOverFull)
    }
    
    
}
//MARK: CollectionView datasource
extension BookViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "section-header-element-kind") { [weak self]
                   (supplementaryView, string, indexPath) in
            guard let self = self else {return}
               }
        
        let cellRegistration = UICollectionView.CellRegistration<DiaryCollectionViewCell, Diary>.init { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else {return}
            
            cell.questionLabel.text = itemIdentifier.card?.question
            cell.deleteButton.isHidden = !self.nowEditing
            cell.dateLabel.text = itemIdentifier.date.formatted(date: .abbreviated, time: .omitted)
            cell.diaryLabel.text = itemIdentifier.text
            
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

extension BookViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = dataSource.itemIdentifier(for: indexPath)
//        let snapShot = dataSource.snapshot()
        guard let cell = collectionView.cellForItem(at: indexPath) as? DiaryCollectionViewCell else {return}
//        cell?.questionLabel.text = "뒤집기 테스트"
        cellTapped(cell: cell)
        
    }
   
}
