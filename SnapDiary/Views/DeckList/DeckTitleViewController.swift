//
//  DeckTitleViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/07.
//

import UIKit

final class DeckTitleViewContoller: BaseViewController, UITextFieldDelegate {
        
    private let mainView = DeckTitleView()
    private let deck: Deck
  
    init(deck: Deck) {
        self.deck = deck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        view = mainView
        mainView.titleTextField.delegate = self
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        mainView.saveButton.isEnabled = false
        mainView.saveButton.setTitleColor(.systemGray3, for: .normal)
        mainView.titleTextField.text = deck.title
    }
    
    @objc private func saveButtonPressed() {
        guard let text = mainView.titleTextField.text else {
            return
        }
        repository.modifyItem {_ in 
            deck.title = text
        }
        refreshRootViewWillAppear(type: DeckDetailViewController.self)
        dismiss(animated: true)
    }
    private func saveButtonSet() {
        if let text = mainView.titleTextField.text, !text.isEmpty  {
            mainView.saveButton.isEnabled = true
            mainView.saveButton.setTitleColor(.systemBlue, for: .normal)
        } else {
            mainView.saveButton.isEnabled = false
            mainView.saveButton.setTitleColor(.systemGray3, for: .normal)
            
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        saveButtonSet()
    }
    
}


final class DeckTitleView: BaseView {
    let titleTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = Constants.Color.background
        view.placeholder = "덱 이름을 수정한 후 저장해주세요"
        return view
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.background
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
       let view = UILabel()
        view.text = "제목 수정"
        return view
    }()
    
    override func configure() {
        super.configure()
        backgroundColor = .clear
        [centerView, saveButton, titleTextField, dismissButton, titleLabel].forEach {addSubview($0)}
        let margin = 4
        centerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(centerView.snp.bottom)
            make.trailing.equalTo(centerView.snp.trailing)
            make.width.equalTo(44)
        }
        titleTextField.snp.makeConstraints { make in
            make.bottom.equalTo(centerView.snp.bottom).inset(margin)
            make.trailing.equalTo(saveButton.snp.leading)
            make.leading.equalTo(centerView.snp.leading).inset(8)
           
        }
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top)
            make.leading.equalTo(centerView.snp.leading).inset(margin)
            
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top).inset(margin)
            make.centerX.equalTo(centerView.snp.centerX)
        }
    }
}
