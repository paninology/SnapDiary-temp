//
//  deckPickerCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit

final class DeckPickerCell: UITableViewCell {
    
 
    let deckPicker: UIPickerView = {
       let view = UIPickerView()
        
        return view
    }()
    
    let detailButton: UIButton = {
       let view = UIButton()
        view.setTitle("상세보기", for: .normal)
        view.setTitleColor(.label, for: .normal)
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        [detailButton, deckPicker].forEach {addSubview($0)}
        detailButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
        deckPicker.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(detailButton.snp.leading)
            
        }
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
