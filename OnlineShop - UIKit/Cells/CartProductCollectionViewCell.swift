//
//  CartProductCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit

class CartProductCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let labelHeight: CGFloat = 12
    let valueLabelHeight: CGFloat = 17
    let quantityViewHeight: CGFloat = 25
    let buttonHeight: CGFloat = 25
    
    let cartProductImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .systemGray2
        
        return imageView
    }()
    
    let cartProductDataView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let cartProductNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let cartProductNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let cartProductOldPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Old price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let cartProductOldPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let cartProductNewPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let cartProductNewPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let cartProductQuantityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Quantity"
        label.font = .systemFont(ofSize: 10)
        
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
    
    let cartProductQuantityUpdateButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    let cartProductRemoveButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Remove", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .systemRed
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
        
        contentView.addSubview(cartProductImageView)
        cartProductImageView.contentMode = .scaleToFill
        cartProductImageView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalTo(cartProductImageView.snp.height)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        contentView.addSubview(cartProductDataView)
        cartProductDataView.snp.makeConstraints { make -> Void in
            make.leading.equalTo(cartProductImageView.snp.trailing).offset(horizontalOffset)
            make.trailing.equalToSuperview().offset(-horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        cartProductDataView.addSubview(cartProductNameLabel)
        cartProductNameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        cartProductDataView.addSubview(cartProductNameValueLabel)
        cartProductNameValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(cartProductNameLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        cartProductDataView.addSubview(cartProductOldPriceLabel)
        cartProductOldPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(cartProductNameValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        cartProductDataView.addSubview(cartProductOldPriceValueLabel)
        cartProductOldPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(cartProductOldPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        cartProductDataView.addSubview(cartProductNewPriceLabel)
        cartProductNewPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(cartProductOldPriceLabel.snp.trailing)
            make.top.equalTo(cartProductNameValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        cartProductDataView.addSubview(cartProductNewPriceValueLabel)
        cartProductNewPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(cartProductOldPriceValueLabel.snp.trailing)
            make.top.equalTo(cartProductNewPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        cartProductDataView.addSubview(cartProductQuantityLabel)
        cartProductQuantityLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(cartProductNewPriceValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        cartProductDataView.addSubview(cartProductQuantityUpdateButton)
        cartProductQuantityUpdateButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset * 1.5).dividedBy(2)
            make.height.equalTo(buttonHeight)
        }
        
        cartProductDataView.addSubview(decreaseQuantityButton)
        decreaseQuantityButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(cartProductQuantityLabel.snp.bottom).offset(verticalOffset)
            make.width.equalTo(decreaseQuantityButton.snp.height)
            make.height.equalTo(quantityViewHeight)
        }
        
        cartProductDataView.addSubview(increaseQuantityButton)
        increaseQuantityButton.snp.makeConstraints { make -> Void in
            make.trailing.equalTo(cartProductQuantityUpdateButton)
            make.top.equalTo(cartProductQuantityLabel.snp.bottom).offset(verticalOffset)
            make.width.equalTo(increaseQuantityButton.snp.height)
            make.height.equalTo(quantityViewHeight)
        }
        
        cartProductDataView.addSubview(quantityLabel)
        quantityLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(decreaseQuantityButton.snp.trailing).offset(horizontalOffset)
            make.trailing.equalTo(increaseQuantityButton.snp.leading).offset(-horizontalOffset)
            make.top.equalTo(cartProductQuantityLabel.snp.bottom).offset(verticalOffset)
            make.height.equalTo(quantityViewHeight)
        }
        
        cartProductDataView.addSubview(cartProductRemoveButton)
        cartProductRemoveButton.snp.makeConstraints { make -> Void in
            make.leading.equalTo(cartProductQuantityUpdateButton.snp.trailing).offset(horizontalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset * 1.5).dividedBy(2)
            make.height.equalTo(buttonHeight)
        }
    }
}
