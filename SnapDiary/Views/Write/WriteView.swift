//
//  WriteView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit

//날짜(모달팝업),질문,질문변경,질문카드 추가, 답변,사진등록(1장)
//날짜: 데이트피커, 라벨 카드선택: 컬렉션뷰, 버튼, 라벨, 일기작성: 텍스트뷰
final class WriteView: BaseView {
    
    let titleLable: UILabel = {
       let view = UILabel()
        return view
    }()
    let dateLable: UILabel = {
       let view = UILabel()
        return view
    }()
    let datepicker: UIDatePicker = {
       let view = UIDatePicker()
        return view
    }()
    let collectionView = SingleLineCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    let deckEditButton: UIButton = {
       let view = UIButton()
        return view
    }()

    let questionLable: UILabel = {
        let view = UILabel()
        view.text = "오늘 아침 메뉴는?"
        return view
    }()
    let textView: UITextView = {
        let view = UITextView()
        return view
    }()
    
    override func configure() {
        super.configure()
//        collectionView.
        [titleLable, dismissButton, saveButton, dateLable, datepicker, collectionView, questionLable, textView].forEach{ addSubview($0)}
    }
    
    override func setConstraints() {
        super.setConstraints()
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            
        }
        dismissButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        dateLable.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(8)
//            make.trailing.equalTo(datepicker.snp.leading).inset(4)
        }
        datepicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateLable)
            make.trailing.equalToSuperview().inset(8)
//            make.leading.greaterThanOrEqualTo(dateLable.snp.trailing)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(datepicker.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(collectionView.snp.width).multipliedBy(0.3)
        }
        questionLable.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(questionLable.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(4)
            
        }
    }
    
    
    
}
