//
//  CollectionLayoutMenuCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 24.01.2024..
//

import UIKit

class CollectionLayoutMenuCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        
        contentView.backgroundColor = .systemGray3
        contentView.layer.cornerRadius = 10
        contentView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        contentView.addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-4 * horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
    }
}
