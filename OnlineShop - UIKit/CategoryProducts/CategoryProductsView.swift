//
//  CategoryProductsView.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit

class CategoryProductsView: UIView {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    
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
    
    let categoryProductsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        
        return collectionView
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
        
        contentView.addSubview(categoryProductsCollectionView)
        categoryProductsCollectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
    }
}
