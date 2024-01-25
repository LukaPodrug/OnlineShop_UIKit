//
//  ProductView.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 24.01.2024..
//

import UIKit
import SnapKit

class ProductView: UIView {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let productDataViewHeigth: CGFloat = 420
    let producGalleryCollectionViewHeight: CGFloat = 80
    let labelHeight: CGFloat = 12
    let valueLabelHeight: CGFloat = 17
    let quantityViewHeight: CGFloat = 35
    let buttonHeight: CGFloat = 35
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .systemGray4
        
        return imageView
    }()
    
    let productDataView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let productGalleryCollectionView: UICollectionView = {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
    
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray4
        collectionView.layer.cornerRadius = 10
        
        return collectionView
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
    
    let productBrandLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Brand"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let productBrandValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let productRatingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Rating"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let productRatingValueLabel: UILabel = {
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
    
    let productDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Description"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let productDescriptionValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
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
        label.backgroundColor = .systemGray4
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
    
    let productAddButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.greaterThanOrEqualToSuperview().offset(-2 * verticalOffset)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(productDataView)
        productDataView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(productDataViewHeigth)
        }
        
        productDataView.addSubview(productGalleryCollectionView)
        productGalleryCollectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(producGalleryCollectionViewHeight)
        }
        
        productDataView.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productGalleryCollectionView.snp.bottom).offset(verticalOffset)
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
        
        productDataView.addSubview(productBrandLabel)
        productBrandLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productNameValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productBrandValueLabel)
        productBrandValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productBrandLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        productDataView.addSubview(productRatingLabel)
        productRatingLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productBrandValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productRatingValueLabel)
        productRatingValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productRatingLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(valueLabelHeight)
        }
        
        productDataView.addSubview(productOldPriceLabel)
        productOldPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productRatingValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productOldPriceValueLabel)
        productOldPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productOldPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        productDataView.addSubview(productNewPriceLabel)
        productNewPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(productOldPriceLabel.snp.trailing)
            make.top.equalTo(productRatingValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productNewPriceValueLabel)
        productNewPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(productOldPriceValueLabel.snp.trailing)
            make.top.equalTo(productNewPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        productDataView.addSubview(productDescriptionLabel)
        productDescriptionLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productOldPriceValueLabel.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        productDataView.addSubview(productDescriptionValueLabel)
        productDescriptionValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(productDescriptionLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
        }
        
        productDataView.addSubview(productAddButton)
        productAddButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(buttonHeight)
        }
        
        productDataView.addSubview(decreaseQuantityButton)
        decreaseQuantityButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalTo(productAddButton.snp.top).offset(-verticalOffset)
            make.width.equalTo(decreaseQuantityButton.snp.height)
            make.height.equalTo(quantityViewHeight)
        }
        
        productDataView.addSubview(increaseQuantityButton)
        increaseQuantityButton.snp.makeConstraints { make -> Void in
            make.trailing.equalToSuperview().offset(-horizontalOffset)
            make.bottom.equalTo(productAddButton.snp.top).offset(-verticalOffset)
            make.width.equalTo(increaseQuantityButton.snp.height)
            make.height.equalTo(quantityViewHeight)
        }
        
        productDataView.addSubview(quantityLabel)
        quantityLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(decreaseQuantityButton.snp.trailing).offset(horizontalOffset)
            make.trailing.equalTo(increaseQuantityButton.snp.leading).offset(-horizontalOffset)
            make.bottom.equalTo(productAddButton.snp.top).offset(-verticalOffset)
            make.height.equalTo(quantityViewHeight)
        }
        
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.bottom.equalTo(productDataView.snp.top).offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
        }
    }
}
