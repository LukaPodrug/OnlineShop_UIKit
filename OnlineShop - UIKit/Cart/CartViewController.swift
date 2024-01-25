//
//  CartViewController.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import Combine
import SnapKit
import SDWebImage

class CartViewController: UIViewController {
    let cartProductCellHeight: CGFloat = 170
    
    let cartViewModel: CartViewModel
    let cartView: CartView
    var cancellables: Set<AnyCancellable>
    
    var paymentButtonEnabled: Bool {
        didSet {
            updatePaymentButtonEnabled(enabled: paymentButtonEnabled)
        }
    }
    
    init(cartData: CartModel) {
        self.cartViewModel = CartViewModel(cartData: cartData)
        self.cartView = CartView()
        self.cancellables = Set<AnyCancellable>()
        
        self.paymentButtonEnabled = false
        
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
        
        view.addSubview(cartView)
        cartView.snp.makeConstraints { make -> Void in
            make.leading.top.width.height.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUIFunctionality() {
        cartViewModel.cartViewModelDelegate = self
        
        cartView.cartProductsCollectionView.dataSource = self
        cartView.cartProductsCollectionView.delegate = self
        cartView.cartProductsCollectionView.register(CartProductCollectionViewCell.self, forCellWithReuseIdentifier: "CartProductCell")
        cartView.cartProductsCollectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        
        cartViewModel.validatedCart
            .assign(to: \.paymentButtonEnabled, on: self)
            .store(in: &cancellables)
    }
    
    func setupUIData() {
        cartView.numberOfProductsValueLabel.text = "\(cartViewModel.cartData.totalProducts)"
        cartView.totalQuantityValueLabel.text = "\(cartViewModel.cartData.totalQuantity)"
        
        let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", cartViewModel.cartData.total))
        attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
        cartView.oldPriceValueLabel.attributedText = attributedOldPriceString
        
        cartView.newPriceValueLabel.text = String(format: "%.2f€", cartViewModel.cartData.discountedTotal)
    }
}

extension CartViewController {
    @objc func decreaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CartProductCollectionViewCell = cartView.cartProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CartProductCollectionViewCell
        
        cell.quantityLabel.text = "\(Int(cell.quantityLabel.text!)! - 1)"
        cell.decreaseQuantityButton.isEnabled = Int(cell.quantityLabel.text!)! == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = Int(cell.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
        
        cell.cartProductQuantityUpdateButton.isEnabled = Int(cell.quantityLabel.text!)! == cartViewModel.cartData.products[sender.tag].quantity ? false : true
        cell.cartProductQuantityUpdateButton.backgroundColor = Int(cell.quantityLabel.text!)! == cartViewModel.cartData.products[sender.tag].quantity ? .systemGray2 : .systemBlue

    }
    
    @objc func increaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CartProductCollectionViewCell = cartView.cartProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CartProductCollectionViewCell
        
        cell.quantityLabel.text = "\(Int(cell.quantityLabel.text!)! + 1)"
        cell.decreaseQuantityButton.isEnabled = Int(cell.quantityLabel.text!)! == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = Int(cell.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
        
        cell.cartProductQuantityUpdateButton.isEnabled = Int(cell.quantityLabel.text!)! == cartViewModel.cartData.products[sender.tag].quantity ? false : true
        cell.cartProductQuantityUpdateButton.backgroundColor = Int(cell.quantityLabel.text!)! == cartViewModel.cartData.products[sender.tag].quantity ? .systemGray2 : .systemBlue
    }
    
    @objc func updateCartProductQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CartProductCollectionViewCell = cartView.cartProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CartProductCollectionViewCell
        
        cartViewModel.updateCart(productId: cartViewModel.cartData.products[sender.tag].id, productQuantity: Int(cell.quantityLabel.text!)!)
    }
    
    @objc func removeCartProductButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        cartViewModel.updateCart(productId: cartViewModel.cartData.products[sender.tag].id, productQuantity: 0)
    }
}

extension CartViewController {
    func updatePaymentButtonEnabled(enabled: Bool) {
        cartView.paymentButton.isEnabled = enabled
        cartView.paymentButton.updateBackgroundColor(backgroundColor: enabled == true ? .systemBlue : .systemGray4)
    }
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.cartData.totalProducts == 0 ? 1 : cartViewModel.cartData.totalProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cartViewModel.cartData.totalProducts == 0 {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCollectionViewCell
            
            emptyCell.setupUI()
            
            return emptyCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartProductCell", for: indexPath) as! CartProductCollectionViewCell
        
        cell.setupUI()
        
        cell.decreaseQuantityButton.tag = indexPath.row
        cell.decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantityButtonPress(sender:)), for: .touchUpInside)
        cell.increaseQuantityButton.tag = indexPath.row
        cell.increaseQuantityButton.addTarget(self, action: #selector(increaseQuantityButtonPress(sender:)), for: .touchUpInside)
        cell.cartProductQuantityUpdateButton.tag = indexPath.row
        cell.cartProductQuantityUpdateButton.addTarget(self, action: #selector(updateCartProductQuantityButtonPress(sender:)), for: .touchUpInside)
        cell.cartProductRemoveButton.tag = indexPath.row
        cell.cartProductRemoveButton.addTarget(self, action: #selector(removeCartProductButtonPress(sender:)), for: .touchUpInside)
        
        cell.decreaseQuantityButton.isEnabled = cartViewModel.cartData.products[indexPath.row].quantity == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = cartViewModel.cartData.products[indexPath.row].quantity == 1 ? .systemGray2 : .systemBlue
        cell.cartProductQuantityUpdateButton.isEnabled = false
        cell.cartProductQuantityUpdateButton.backgroundColor = .systemGray2
        
        cell.cartProductNameValueLabel.text = cartViewModel.cartData.products[indexPath.row].title
        
        let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", cartViewModel.cartData.products[indexPath.row].total))
        attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
        cell.cartProductOldPriceValueLabel.attributedText = attributedOldPriceString
        
        cell.cartProductNewPriceValueLabel.text = String(format: "%.2f€", cartViewModel.cartData.products[indexPath.row].discountedPrice)
        cell.quantityLabel.text = "\(cartViewModel.cartData.products[indexPath.row].quantity)"
        
        guard let imageURL = URL(string: cartViewModel.cartData.products[indexPath.row].thumbnail) else {
            cell.cartProductImageView.image = UIImage(systemName: "photo")
            return cell
        }
        
        cell.cartProductImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.cartProductImageView.sd_imageIndicator?.startAnimatingIndicator()
        cell.cartProductImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cartProductCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CartViewController: CartViewModelDelegate {
    func updateCartProductsCollection() {
        cartView.cartProductsCollectionView.animatedReload()
    }
    
    func updateCartTotalView() {
        cartView.numberOfProductsValueLabel.text = "\(cartViewModel.cartData.totalProducts)"
        cartView.totalQuantityValueLabel.text = "\(cartViewModel.cartData.totalQuantity)"
        
        let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", cartViewModel.cartData.total))
        attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
        cartView.oldPriceValueLabel.attributedText = attributedOldPriceString
        
        cartView.newPriceValueLabel.text = String(format: "%.2f€", cartViewModel.cartData.discountedTotal)
    }
    
    func showErrorAlert(message: String) {
        let alertController: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
