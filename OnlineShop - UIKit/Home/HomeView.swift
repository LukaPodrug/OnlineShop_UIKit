//
//  HomeView.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit

class HomeView: UIView {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let displayMenuViewHeight: CGFloat = 50
    let collectionLayoutMenuCollectionViewHeight: CGFloat = 50
    let productsCollectionViewHeight: CGFloat = 250
    
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
    
    let displayMenuView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let searchTextField: CustomTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "Search"
        textField.font = textField.font?.withSize(15)
        textField.backgroundColor = .systemGray4
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    let tableViewButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.tintColor = .white
        
        return button
    }()
    
    let collectionViewButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "tablecells"), for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.tintColor = .systemBlue
        
        return button
    }()
    
    let categoriesTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
        tableView.layer.cornerRadius = 10
        
        return tableView
    }()
    
    let searchedProductsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    
    let collectionLayoutView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let collectionLayoutMenuCollectionView: UICollectionView = {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
    
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray4
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    
    let collectionLayoutProductsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemGray4
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    
    let productsCollectionView: UICollectionView = {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
    
        collectionView.showsHorizontalScrollIndicator = false
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
        
        contentView.addSubview(displayMenuView)
        displayMenuView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(displayMenuViewHeight)
        }
        
        displayMenuView.addSubview(collectionViewButton)
        collectionViewButton.snp.makeConstraints { make -> Void in
            make.trailing.equalToSuperview().offset(-horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalTo(collectionViewButton.snp.height)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        displayMenuView.addSubview(tableViewButton)
        tableViewButton.snp.makeConstraints { make -> Void in
            make.trailing.equalTo(collectionViewButton.snp.leading).offset(-horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalTo(tableViewButton.snp.height)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        displayMenuView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.trailing.equalTo(tableViewButton.snp.leading).offset(-horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.height.equalToSuperview().offset(-2 * verticalOffset)
        }
        
        contentView.addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(productsCollectionViewHeight)
        }
        
        contentView.addSubview(categoriesTableView)
        categoriesTableView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(displayMenuView.snp.bottom).offset(verticalOffset)
            make.bottom.equalTo(productsCollectionView.snp.top).offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
        }
        
        contentView.addSubview(searchedProductsCollectionView)
        searchedProductsCollectionView.snp.makeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        contentView.addSubview(collectionLayoutView)
        collectionLayoutView.snp.makeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        collectionLayoutView.addSubview(collectionLayoutMenuCollectionView)
        collectionLayoutMenuCollectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(collectionLayoutMenuCollectionViewHeight)
        }
        
        collectionLayoutView.addSubview(collectionLayoutProductsCollectionView)
        collectionLayoutProductsCollectionView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(collectionLayoutMenuCollectionView.snp.bottom).offset(verticalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
        }
    }
}
