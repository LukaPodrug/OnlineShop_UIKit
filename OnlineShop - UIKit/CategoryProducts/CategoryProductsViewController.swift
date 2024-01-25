//
//  CategoryProductsViewController.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import SnapKit
import SDWebImage

class CategoryProductsViewController: UIViewController {
    let categotyProductCellHeight: CGFloat = 215
    
    let categoryProductsViewModel: CategoryProductsViewModel
    let categoryProductsView: CategoryProductsView
    
    init(cartData: CartModel, categoryName: String) {
        self.categoryProductsViewModel = CategoryProductsViewModel(cartData: cartData, categoryName: categoryName)
        self.categoryProductsView = CategoryProductsView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupUIFunctionality()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(categoryProductsView)
        categoryProductsView.snp.makeConstraints { make -> Void in
            make.leading.top.width.height.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUIFunctionality() {
        categoryProductsViewModel.categoryProductsViewModelDelegate = self
        
        categoryProductsView.categoryProductsCollectionView.dataSource = self
        categoryProductsView.categoryProductsCollectionView.delegate = self
        categoryProductsView.categoryProductsCollectionView.register(CategoryProductCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryProductCell")
    }
}

extension CategoryProductsViewController {
    @objc func categoryProductCellPress(sender: CustomTapGestureRecognizer) {
        sender.view?.onViewPressAnimation()
        showProductModal(product: categoryProductsViewModel.categoryProducts[sender.tag])
    }
    
    @objc func decreaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CategoryProductCollectionViewCell = categoryProductsView.categoryProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CategoryProductCollectionViewCell
        
        cell.quantityLabel.text = "\(Int(cell.quantityLabel.text!)! - 1)"
        cell.decreaseQuantityButton.isEnabled = Int(cell.quantityLabel.text!)! == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = Int(cell.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
    }
    
    @objc func increaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CategoryProductCollectionViewCell = categoryProductsView.categoryProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CategoryProductCollectionViewCell
        
        cell.quantityLabel.text = "\(Int(cell.quantityLabel.text!)! + 1)"
        cell.decreaseQuantityButton.isEnabled = Int(cell.quantityLabel.text!)! == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = Int(cell.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
    }
    
    @objc func addCategoryProductButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CategoryProductCollectionViewCell = categoryProductsView.categoryProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CategoryProductCollectionViewCell
        
        categoryProductsViewModel.updateCart(productId: categoryProductsViewModel.categoryProducts[sender.tag].id, productQuantity: Int(cell.quantityLabel.text!)!, productRow: sender.tag)
    }
}

extension CategoryProductsViewController {
    func showProductModal(product: ProductModel) {
        let productViewController: ProductViewController = ProductViewController(cartData: categoryProductsViewModel.cartData, product: product)
        
        productViewController.productViewModel.productViewModelParentDelegate = self
        
        present(productViewController, animated: true)
    }
}

extension CategoryProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProductsViewModel.categoryProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryProductCell", for: indexPath) as! CategoryProductCollectionViewCell
        
        cell.setupUI()
        
        let tapRecognizer: CustomTapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(categoryProductCellPress(sender:)))
        tapRecognizer.tag = indexPath.row
        cell.contentView.addGestureRecognizer(tapRecognizer)
        
        cell.decreaseQuantityButton.tag = indexPath.row
        cell.decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantityButtonPress(sender:)), for: .touchUpInside)
        cell.increaseQuantityButton.tag = indexPath.row
        cell.increaseQuantityButton.addTarget(self, action: #selector(increaseQuantityButtonPress(sender:)), for: .touchUpInside)
        cell.categoryProductAddButton.tag = indexPath.row
        cell.categoryProductAddButton.addTarget(self, action: #selector(addCategoryProductButtonPress(sender:)), for: .touchUpInside)
        
        cell.decreaseQuantityButton.isEnabled = false
        cell.decreaseQuantityButton.backgroundColor = .systemGray2
        
        cell.categoryProductNameValueLabel.text = categoryProductsViewModel.categoryProducts[indexPath.row].title
        cell.categoryProductBrandValueLabel.text = categoryProductsViewModel.categoryProducts[indexPath.row].brand
        cell.categoryProductRatingValueLabel.text = String(format: "%.2f", categoryProductsViewModel.categoryProducts[indexPath.row].rating)
        
        let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", categoryProductsViewModel.categoryProducts[indexPath.row].price))
        attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
        cell.categoryProductOldPriceValueLabel.attributedText = attributedOldPriceString
        
        cell.categoryProductNewPriceValueLabel.text = String(format: "%.2f€", categoryProductsViewModel.categoryProducts[indexPath.row].price * (100 - categoryProductsViewModel.categoryProducts[indexPath.row].discountPercentage) / 100)
        cell.quantityLabel.text = "\(1)"
        
        guard let imageURL = URL(string: categoryProductsViewModel.categoryProducts[indexPath.row].thumbnail) else {
            cell.categoryProductImageView.image = UIImage(systemName: "photo")
            return cell
        }
        
        cell.categoryProductImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.categoryProductImageView.sd_imageIndicator?.startAnimatingIndicator()
        cell.categoryProductImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2 + categotyProductCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CategoryProductsViewController: ProductViewModelParentDelegate {
    func updateCartData(cartData: CartModel) {
        categoryProductsViewModel.categoryProductsViewModelParentDelegate?.updateCartData(cartData: cartData)
    }
}

extension CategoryProductsViewController: CategoryProductsViewModelDelegate {
    func updateCategoryProductsCollection() {
        categoryProductsView.categoryProductsCollectionView.animatedReload()
    }
    
    func showErrorAlert(message: String) {
        let alertController: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
