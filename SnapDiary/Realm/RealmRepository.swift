//
//  RealmRepository.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/02.
//

import Foundation
import RealmSwift

protocol RealmRepositoryType {
    func fetch<T: RealmFetchable>(model: T.Type) -> Results<T>
    func addItem<T: Object>(items: T)
//    func updateItem<T: Object>(item: T)
    func deleteItem<T: Object>(item: T)
//    func modifyItems(items: Any)
}

final class RealmRepository: RealmRepositoryType {
 
   
    let localRealm = try! Realm()
    
    func showRealmURL() {
        print(localRealm.configuration.fileURL ?? "realmURL error")
    }
   
    func fetch<T: RealmFetchable>(model: T.Type) -> Results<T> {
        
        return localRealm.objects(model)
    }
    
    
    func addItem<T: Object>(items: T)  {
        do {
            try localRealm.write {
                localRealm.add(items)
            }
        } catch let error {
            print(error)
        }
    }
  
  
//    func fetchSort(_ sort: String) -> Results<MemoRealmModel> {
//        return localRealm.objects(MemoRealmModel.self).sorted(byKeyPath: sort, ascending: true)
//    }
  
    func updateItem<T: Object>(item: T, update: String, value: Any) {
        try! localRealm.write {
            //하나의 레코드에서 특정 칼럼 하나만 변경
//            item.favorite.toggle()
            
            //하나의 테이블에 특정 칼럼특정 칼럼 전체 값을 변경
    //                self.tasks.setValue(true, forKey: "favorite")
            
            //하나의 레코드에서 여러 칼럼들이 변경
            localRealm.create(T.self, value: [update: value] , update: .modified)

        }
//        if let realm = try? Realm(),
//           let card = realm.object(ofType: Card.self, forPrimaryKey: primaryKey) {
//            try? realm.write {
//                card.question = mainView.textView.text
//                // 다른 속성도 필요에 따라 수정할 수 있음
//            }
//        }
        
    }

    
    func deleteItem<T: Object>(item: T) {
        try! localRealm.write {
            localRealm.delete(item)
        }
    }
    func appendCardToDeck(cards: [Card], deck: Deck) {
        do {
            try localRealm.write {
                deck.cards.append(objectsIn: cards)
            }
        } catch let error {
            print(error)
        }
    }
    func appendDiaryToBook(diary: Diary, book: Book) {
        do {
            try localRealm.write {
                book.diaries.append(diary)
            }
        } catch let error {
            print(error)
        }
    }
    
    func modifyItem(completion: (_ realm: Realm)-> Void) {
        do {
            try localRealm.write {
                completion(localRealm)
            }
        } catch let error {
            print(error)
        }
    }
    func cardUsingDeck(card: Card)-> [String] {
        // 예시로 찾을 특정 Card의 objectId
        let cardObjectId = card.objectId

        // cards에 특정 Card를 포함하는 모든 Deck을 쿼리합니다
        let decksWithCard = localRealm.objects(Deck.self).filter("ANY cards.objectId == %@", cardObjectId)
        // 결과 출력
        var deckTitles: [String] = []
            for deck in decksWithCard {
                deckTitles.append(deck.title)
            }
        return deckTitles
    }
    
    
    
}
