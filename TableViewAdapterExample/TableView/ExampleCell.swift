//
//  ExampleCell.swift
//  TableViewAdapterExample
//
//  Created by seokho on 2021/06/28.
//

import UIKit

import Then
import SnapKit

class ExampleCell: BaseTableViewCell {
    lazy var nameLabel = UILabel()
    
    func config(name: String) {
        self.nameLabel.text = name
        
        self.layoutIfNeeded()
    }
    
    override func configureUI() {
        super.configureUI()
        
        defer {
            self.setupConstraints()
        }
        
        nameLabel.do {
            $0.textColor = .label
        }
        
        self.contentView.addSubview(nameLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }

}
