//
//  BookView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/21.
//

import UIKit
//1.일기장 제목, 2.설명, 3.알림옵션, 4.덱이름(수정포함),5.덱 카드들(컬렉션뷰 한줄 가로뷰)?, 6.일기들
//섹션이나 뷰를 두개로 나눈다. 1~5 6~9번 6번만 컬렉션뷰로
//일기셀: 날짜, 날씨?, 질문, 내용. 클릭시 뒤집기로 내용보기, 버튼으로 크게보기 or 클릭시 크게보기
//7.보기옵션: 카드 앞면보기, 뒷면보기, 같이보기, 리스트로보기
//8.정렬: 최신부터, 처음부터, 카드별
// 9.필터: 카드별, 기간으로 검색 -> 업데이트로 빼도...
//새일기 쓰기, 일기장 수정, 유저디폴트로 이니셜뷰 설정.

final class BookView: BaseView {
   
    let bookDetailView = BookDetailView()
 
    let collectionView = CardListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    let writeButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 28
        view.clipsToBounds = true
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.shadowRadius = 4
//        view.layer.borderWidth = 0.2
//        view.layer.borderColor = UIColor.label.cgColor
        view.backgroundColor = .systemGray6
        view.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
//        view.setTitle("일기쓰기", for: .normal)
        view.tintColor = .label
        view.setTitleColor(.label, for: .normal)
        let pointSize: CGFloat = 20
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = imageConfig
        view.configuration = config
        

        return view
    }()
 
    override func configure() {
        super.configure()
        
        [ collectionView, bookDetailView, writeButton ].forEach {addSubview($0)}
    }
    
    override func setConstraints() {
        super.setConstraints()
        bookDetailView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(bookDetailView.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
        writeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(24)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
    }
}
