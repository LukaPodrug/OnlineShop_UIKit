//
//  CategoryTableViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let labelHeight: CGFloat = 17
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        layer.cornerRadius = 10
        
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 10
        contentView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-4 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
    }
}
