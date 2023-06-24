//
//  BaseViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import UIKit
import RealmSwift

class BaseViewController: UIViewController {
    
    let repository = RealmRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUI()
    }

    
    func configure() {
        
    }
    
    func setUI() {
        
    }
    
    func showAlertWithCompletion(title: String, message: String, hasCancelButton: Bool, completion: ( (UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: completion)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        if hasCancelButton {
            alert.addAction(cancel)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func refreshRootViewWillAppear<T: UIViewController>(rootVC: T.Type) {
        if let vc = presentingViewController as? T {
            vc.viewWillAppear(true)
        }
    }
     func makeSnapShot<T: Hashable>(items: [T], dataSource: UICollectionViewDiffableDataSource<Int, T>) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, T>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    @objc func dismissButtonPressed() {
        dismiss(animated: true)
    }
}
