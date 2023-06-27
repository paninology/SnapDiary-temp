//
//  BookSettingViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/27.
//

import UIKit
import RealmSwift

final class SetiingBookViewController: BookSettingViewController {
   
    override func saveButtonPressed(sender: UIButton) {
        let noti = isNotiOn ? selectedOption : nil
        guard titleText != "",
              subTitleText != "" else {
            showAlertWithCompletion(title: "입력이 완료되지 않았습니다.", message: "제목과 설명을 작성해주세요", hasCancelButton: false, completion: nil)
            return
        }
        guard let newDeck = selectedDeck else {
            showAlertWithCompletion(title: "선택된 덱이 없습니다.", message: "기존 덱을 선택하거나, 새로운 덱을 편집해서 나만의 덱을 만들어주세요", hasCancelButton: false, completion: nil)
            return
        }
//        let book = repository.localRealm.
//        let book = Book(title: titleText, deck: deck, subtitle: subTitleText, notiOption: noti, notiDate: notificationDate, diaries: List())
        repository.updateBook(book: self.book, completion: <#T##(Book) -> Void##(Book) -> Void##(_ oldBook: Book) -> Void#>)
        refreshRootViewWillAppear(type: BookListViewController.self)
        dismiss(animated: true)
    }
}
