//
//  BaseView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/22.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    let dismissButton: UIButton = {
        let view = UIButton(type: .close)
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = Constants.Color.background
    }
    
    func setConstraints() {
        
    }
}
