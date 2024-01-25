//
//  ProductCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 22.01.2024..
//

import UIKit
import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let labelHeight: CGFloat = 12
    let valueLabelHeight: CGFloat = 17
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .systemGray2
        
        return imageView
    }()
    
    let productDataView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let productNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let productOldPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Old price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let productOldPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let productNewPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let productNewPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
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
        
        contentView.addSubview(productImageView)
        productImageView.contentMode = .scaleToFill
        productImageView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalTo(productImageView.snp.height).offset(-horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset).dividedBy(2)
        }
        
        contentView.addSubview(productDataView)
        productDataView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productImageView.snp.bottom).offset(verticalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
        }
        
        productDataView.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productNameValueLabel)
        productNameValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productNameLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        productDataView.addSubview(productOldPriceLabel)
        productOldPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productNameValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productOldPriceValueLabel)
        productOldPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productOldPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        productDataView.addSubview(productNewPriceLabel)
        productNewPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productOldPriceValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productNewPriceValueLabel)
        productNewPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productNewPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
    }
}
