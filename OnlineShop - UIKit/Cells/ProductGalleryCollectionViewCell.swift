//
//  ProductGalleryCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 24.01.2024..
//

import UIKit
import SnapKit

class ProductGalleryCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    
    let productGalleryImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .systemGray2
        
        return imageView
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
        
        contentView.addSubview(productGalleryImageView)
        productGalleryImageView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
    }
}
