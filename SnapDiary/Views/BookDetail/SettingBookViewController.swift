//
//  BookSettingViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/27.
//

import UIKit
import RealmSwift

final class SetiingBookViewController: BookSettingViewController {
    let book: Book
    
    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func configure() {
        super.configure()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장?", style: .plain, target: self, action: #selector(saveButtonPressed))
    }
    
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
        repository.updateBook(book: book) { oldBook in
            book.title = titleText
            book.subtitle = subTitleText
            book.deck = selectedDeck
            book.notiDate = notificationDate
            book.notiOption = noti?.rawValue
        }
        refreshRootViewWillAppear(type: BookViewController.self)
        dismiss(animated: true)
    }
}

extension SetiingBookViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let superView = super.tableView(tableView, cellForRowAt: indexPath)
        
        if indexPath.section == 0 {
            let cell = superView as! TextFeildTableViewCell
            cell.textField.text = book.title
            return cell
        } else if indexPath.section == 1 {
            let cell = superView as! TextFeildTableViewCell
            cell.textField.text = book.subtitle
            return cell
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = superView as! SwitchTableViewCell
                cell.selectSwitch.isOn = book.notiOption == nil ? false : true
                return cell
            } else {
                let cell = superView as! NotificationOptionCell
                cell.datepicker.date = book.notiDate
                let option = NotiOption(rawValue: book.notiOption ?? NotiOption.everyday.rawValue)
                let row = NotiOption.allCases.firstIndex(of: option ?? NotiOption.everyday)
                cell.optionPicker.selectRow(row ?? 0, inComponent: 0, animated: true)
                return cell
            }
        } else {
            let cell = superView as! DeckPickerCell
            if let deckForCell = selectedDeck {
                let row = decks.firstIndex(of: book.deck ?? decks[0]) ?? 0
                cell.deckPicker.selectRow(row, inComponent: 0, animated: true)
            }
            return cell
        }
    }
}
