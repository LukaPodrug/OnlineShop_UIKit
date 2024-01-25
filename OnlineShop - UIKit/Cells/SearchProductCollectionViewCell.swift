//
//  SearchProductCollectionViewCell.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 23.01.2024..
//

import UIKit
import SnapKit

class SearchProductCollectionViewCell: UICollectionViewCell {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let labelHeight: CGFloat = 12
    let valueLabelHeight: CGFloat = 17
    
    let searchProductImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .systemGray2
        
        return imageView
    }()
    
    let searchProductDataView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let searchProductNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let searchProductNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let searchProductBrandLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Brand"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let searchProductBrandValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let searchProductRatingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Rating"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let searchProductRatingValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let searchProductOldPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Old price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let searchProductOldPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let searchProductNewPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New price"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let searchProductNewPriceValueLabel: UILabel = {
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
        
        contentView.addSubview(searchProductImageView)
        searchProductImageView.contentMode = .scaleToFill
        searchProductImageView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalTo(searchProductImageView.snp.height)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        contentView.addSubview(searchProductDataView)
        searchProductDataView.snp.makeConstraints { make -> Void in
            make.leading.equalTo(searchProductImageView.snp.trailing).offset(horizontalOffset)
            make.trailing.equalToSuperview().offset(-horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        searchProductDataView.addSubview(searchProductNameLabel)
        searchProductNameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        searchProductDataView.addSubview(searchProductNameValueLabel)
        searchProductNameValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductNameLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        searchProductDataView.addSubview(searchProductBrandLabel)
        searchProductBrandLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductNameValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        searchProductDataView.addSubview(searchProductBrandValueLabel)
        searchProductBrandValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductBrandLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        searchProductDataView.addSubview(searchProductRatingLabel)
        searchProductRatingLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductBrandValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        searchProductDataView.addSubview(searchProductRatingValueLabel)
        searchProductRatingValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductRatingLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        searchProductDataView.addSubview(searchProductOldPriceLabel)
        searchProductOldPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductRatingValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        searchProductDataView.addSubview(searchProductOldPriceValueLabel)
        searchProductOldPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(searchProductOldPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        searchProductDataView.addSubview(searchProductNewPriceLabel)
        searchProductNewPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(searchProductOldPriceLabel.snp.trailing)
            make.top.equalTo(searchProductRatingValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        searchProductDataView.addSubview(searchProductNewPriceValueLabel)
        searchProductNewPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(searchProductOldPriceValueLabel.snp.trailing)
            make.top.equalTo(searchProductNewPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
    }
}
