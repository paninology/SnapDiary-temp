//
//  File.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit
import RealmSwift
//새일기장: 제목, 알림옵션, 질문덱선택(설정), 사진
//추천 일기옵션 제공
//mvvm + rx으로 변경??
final class AddBookViewController: BookSettingViewController {

    @objc override func saveButtonPressed(sender: UIButton) {
        let noti = isNotiOn ? selectedOption : nil
        guard titleText != "",
              subTitleText != "" else {
            showAlertWithCompletion(title: "입력이 완료되지 않았습니다.", message: "제목과 설명을 작성해주세요", hasCancelButton: false, completion: nil)
            return
        }
        guard let deck = selectedDeck else {
            showAlertWithCompletion(title: "선택된 덱이 없습니다.", message: "기존 덱을 선택하거나, 새로운 덱을 편집해서 나만의 덱을 만들어주세요", hasCancelButton: false, completion: nil)
            return
        }
       
        let book = Book(title: titleText, deck: deck, subtitle: subTitleText, notiOption: noti, notiDate: notificationDate, diaries: List())
        repository.addItem(items: book)
        refreshRootViewWillAppear(type: BookListViewController.self)
        navigationController?.popViewController(animated: true)
    }
    

}
