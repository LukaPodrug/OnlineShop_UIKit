//
//  CategoryProductCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit

class CategoryProductCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let labelHeight: CGFloat = 12
    let valueLabelHeight: CGFloat = 17
    let quantityViewHeight: CGFloat = 25
    let buttonHeight: CGFloat = 25
    
    let categoryProductImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .systemGray2
        
        return imageView
    }()
    
    let categoryProductDataView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let categoryProductNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let categoryProductNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let categoryProductBrandLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Brand"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let categoryProductBrandValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let categoryProductRatingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Rating"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let categoryProductRatingValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let categoryProductOldPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Old price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let categoryProductOldPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let categoryProductNewPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let categoryProductNewPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let decreaseQuantityButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("-", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.clipsToBounds = true
        label.font = .boldSystemFont(ofSize: 15)
        label.backgroundColor = .systemGray2
        label.layer.cornerRadius = 5
        
        return label
    }()
    
    let increaseQuantityButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("+", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    let categoryProductAddButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        
        return button
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
        
        contentView.addSubview(categoryProductImageView)
        categoryProductImageView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(categoryProductImageView.snp.width)
        }
        
        contentView.addSubview(categoryProductDataView)
        categoryProductDataView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductImageView.snp.bottom).offset(verticalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
        }
        
        categoryProductDataView.addSubview(categoryProductNameLabel)
        categoryProductNameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductNameValueLabel)
        categoryProductNameValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductNameLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductBrandLabel)
        categoryProductBrandLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductNameValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductBrandValueLabel)
        categoryProductBrandValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductBrandLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductRatingLabel)
        categoryProductRatingLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductBrandValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductRatingValueLabel)
        categoryProductRatingValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductRatingLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductOldPriceLabel)
        categoryProductOldPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductRatingValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductOldPriceValueLabel)
        categoryProductOldPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(categoryProductOldPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductNewPriceLabel)
        categoryProductNewPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(categoryProductOldPriceLabel.snp.trailing)
            make.top.equalTo(categoryProductRatingValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductNewPriceValueLabel)
        categoryProductNewPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(categoryProductOldPriceValueLabel.snp.trailing)
            make.top.equalTo(categoryProductNewPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        categoryProductDataView.addSubview(categoryProductAddButton)
        categoryProductAddButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(buttonHeight)
        }
        
        categoryProductDataView.addSubview(decreaseQuantityButton)
        decreaseQuantityButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalTo(categoryProductAddButton.snp.top).offset(-verticalOffset)
            make.width.equalTo(decreaseQuantityButton.snp.height)
            make.height.equalTo(quantityViewHeight)
        }
        
        categoryProductDataView.addSubview(increaseQuantityButton)
        increaseQuantityButton.snp.makeConstraints { make -> Void in
            make.trailing.equalToSuperview().offset(-horizontalOffset)
            make.bottom.equalTo(categoryProductAddButton.snp.top).offset(-verticalOffset)
            make.width.equalTo(increaseQuantityButton.snp.height)
            make.height.equalTo(quantityViewHeight)
        }
        
        categoryProductDataView.addSubview(quantityLabel)
        quantityLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(decreaseQuantityButton.snp.trailing).offset(horizontalOffset)
            make.trailing.equalTo(increaseQuantityButton.snp.leading).offset(-horizontalOffset)
            make.bottom.equalTo(categoryProductAddButton.snp.top).offset(-verticalOffset)
            make.height.equalTo(quantityViewHeight)
        }
    }
}
