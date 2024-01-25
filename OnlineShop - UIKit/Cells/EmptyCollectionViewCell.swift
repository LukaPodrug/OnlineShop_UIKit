//
//  EmptyCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 24.01.2024..
//

import UIKit
import SnapKit

class EmptyCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "No products found"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    func setupUI() {
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
        
        contentView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
    }
}
