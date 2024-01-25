//
//  CartView.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit

class CartView: UIView {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let totalSectionViewHeight: CGFloat = 170
    let labelHeight: CGFloat = 17
    let valueLabelHeight: CGFloat = 22
    let buttonHeight: CGFloat = 50
    
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
    
    let cartProductsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    
    let totalSectionView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let numberOfProductsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Number of products"
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let numberOfProductsValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let totalQuantityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Total quantity"
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let totalQuantityValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let oldPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Old price"
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let oldPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let newPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New price"
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let newPriceValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let paymentButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Payment", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
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
        
        contentView.addSubview(cartProductsCollectionView)
        cartProductsCollectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalToSuperview().offset(-3 * verticalOffset - totalSectionViewHeight)
        }
        
        contentView.addSubview(totalSectionView)
        totalSectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(cartProductsCollectionView.snp.bottom).offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(totalSectionViewHeight)
        }
        
        totalSectionView.addSubview(numberOfProductsLabel)
        numberOfProductsLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalToSuperview().offset(2 * verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        totalSectionView.addSubview(numberOfProductsValueLabel)
        numberOfProductsValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalTo(numberOfProductsLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        totalSectionView.addSubview(totalQuantityLabel)
        totalQuantityLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(numberOfProductsLabel.snp.trailing)
            make.top.equalToSuperview().offset(2 * verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        totalSectionView.addSubview(totalQuantityValueLabel)
        totalQuantityValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(numberOfProductsValueLabel.snp.trailing)
            make.top.equalTo(numberOfProductsLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        totalSectionView.addSubview(oldPriceLabel)
        oldPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalTo(numberOfProductsValueLabel.snp.bottom).offset(2 * verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        totalSectionView.addSubview(oldPriceValueLabel)
        oldPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalTo(oldPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        totalSectionView.addSubview(newPriceLabel)
        newPriceLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(oldPriceLabel.snp.trailing)
            make.top.equalTo(totalQuantityValueLabel.snp.bottom).offset(2 * verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(labelHeight)
        }
        
        totalSectionView.addSubview(newPriceValueLabel)
        newPriceValueLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(oldPriceValueLabel.snp.trailing)
            make.top.equalTo(newPriceLabel.snp.bottom)
            make.width.equalToSuperview().offset(-2 * horizontalOffset).dividedBy(2)
            make.height.equalTo(valueLabelHeight)
        }
        
        totalSectionView.addSubview(paymentButton)
        paymentButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.bottom.equalToSuperview().offset(-2 * verticalOffset)
            make.width.equalToSuperview().offset(-4 * horizontalOffset)
            make.height.equalTo(buttonHeight)
        }
    }
}
