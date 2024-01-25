//
//  ProductViewController.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 24.01.2024..
//

import UIKit
import SnapKit
import SDWebImage

class ProductViewController: UIViewController {
    let productViewModel: ProductViewModel
    let productView: ProductView
    
    init(cartData: CartModel, product: ProductModel) {
        self.productViewModel = ProductViewModel(cartData: cartData, product: product)
        self.productView = ProductView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupUIFunctionality()
        setupUIData()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(productView)
        productView.snp.makeConstraints { make -> Void in
            make.leading.top.width.height.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUIFunctionality() {
        productViewModel.productViewModelDelegate = self
        
        productView.productGalleryCollectionView.dataSource = self
        productView.productGalleryCollectionView.delegate = self
        productView.productGalleryCollectionView.register(ProductGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "ProductGalleryCell")
        
        productView.decreaseQuantityButton.isEnabled = false
        productView.decreaseQuantityButton.backgroundColor = .systemGray4
        
        productView.decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantityButtonPress(sender:)), for: .touchUpInside)
        productView.increaseQuantityButton.addTarget(self, action: #selector(increaseQuantityButtonPress(sender:)), for: .touchUpInside)
        productView.productAddButton.addTarget(self, action: #selector(addProductButtonPress(sender:)), for: .touchUpInside)
    }
    
    func setupUIData() {
        guard let imageURL = URL(string: productViewModel.product.thumbnail) else {
            productView.productImageView.image = UIImage(systemName: "photo")
            return
        }
        
        productView.productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        productView.productImageView.sd_imageIndicator?.startAnimatingIndicator()
        productView.productImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
        productView.productNameValueLabel.text = productViewModel.product.title
        productView.productBrandValueLabel.text = productViewModel.product.brand
        productView.productRatingValueLabel.text = "\(productViewModel.product.rating)"
        
        let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", productViewModel.product.price))
        attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
        productView.productOldPriceValueLabel.attributedText = attributedOldPriceString
    
        productView.productNewPriceValueLabel.text = String(format: "%.2f€", productViewModel.product.price * (100 - productViewModel.product.discountPercentage) / 100)
        
        productView.productDescriptionValueLabel.text = productViewModel.product.description
        productView.productDescriptionValueLabel.sizeToFit()
        
        productView.quantityLabel.text = "\(1)"
    }
}

extension ProductViewController {
    @objc func decreaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        productView.quantityLabel.text = "\(Int(productView.quantityLabel.text!)! - 1)"
        productView.decreaseQuantityButton.isEnabled = Int(productView.quantityLabel.text!)! == 1 ? false : true
        productView.decreaseQuantityButton.backgroundColor = Int(productView.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
    }
    
    @objc func increaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()

        productView.quantityLabel.text = "\(Int(productView.quantityLabel.text!)! + 1)"
        productView.decreaseQuantityButton.isEnabled = Int(productView.quantityLabel.text!)! == 1 ? false : true
        productView.decreaseQuantityButton.backgroundColor = Int(productView.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
    }
    
    @objc func addProductButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()

        productViewModel.updateCart(productQuantity: Int(productView.quantityLabel.text!)!)
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.product.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductGalleryCell", for: indexPath) as! ProductGalleryCollectionViewCell
        
        cell.setupUI()
        
        guard let imageURL = URL(string: productViewModel.product.images[indexPath.row]) else {
            cell.productGalleryImageView.image = UIImage(systemName: "photo")
            return cell
        }
        
        cell.productGalleryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.productGalleryImageView.sd_imageIndicator?.startAnimatingIndicator()
        cell.productGalleryImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ProductViewController: ProductViewModelDelegate {
    func updateProductModal() {
        productView.decreaseQuantityButton.isEnabled = false
        productView.decreaseQuantityButton.backgroundColor = .systemGray4
        productView.quantityLabel.text = "\(1)"
    }
}
