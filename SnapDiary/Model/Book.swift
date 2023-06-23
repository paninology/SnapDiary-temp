//
//  Book.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import Foundation
import RealmSwift

//private let dateOptions = ["매일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일", "매월 1일", "매월 15일"]
enum NotiOption: String, CaseIterable {
    case everyday = "매일"
    case monday = "월요일"
    case tuesday = "화요일"
    case wednesday = "수요일"
    case thursday = "목요일"
    case friday = "금요일"
    case saturday = "토요일"
    case sunday = "일요일"
    case monthlyFirst = "매월 1일"
    case monthly15th = "매월 15일"
}

final class Book: Object {
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var title: String //제목(필수)
    @Persisted var deck: Deck? //왜 옵셔널인가...에러난다..왜인지 모르렜다
    @Persisted var subtitle: String //
    @Persisted var notiOption: NotiOption.RawValue? //
    @Persisted var notiDate: Date//
    @Persisted var diaries: List<Diary>//
    
    
    
    convenience init(title: String, deck: Deck, subtitle: String, notiOption: NotiOption?,notiDate: Date, diaries: List<Diary> ) {
        self.init()
        self.title = title
        self.deck = deck
        self.subtitle = subtitle
        self.notiOption = notiOption?.rawValue
        self.notiDate = notiDate
        self.diaries = diaries
    }
}
