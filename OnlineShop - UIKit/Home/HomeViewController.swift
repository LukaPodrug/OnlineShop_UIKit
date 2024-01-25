//
//  HomeViewController.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import UIKit
import Combine
import SnapKit
import SDWebImage

class HomeViewController: UIViewController {
    let keyboardHeightOffset: CGFloat = 45
    let categoryCellHeight: CGFloat = 70
    let collectionLayoutProductCellHeight: CGFloat = 215
    let searchedProductCellHeight: CGFloat = 160
    
    let homeViewModel: HomeViewModel
    let homeView: HomeView
    var cancellables: Set<AnyCancellable>
    
    init(userData: UserModel) {
        self.homeViewModel = HomeViewModel(userData: userData)
        self.homeView = HomeView()
        self.cancellables = Set<AnyCancellable>()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeLoggedOutViewControllers()
        setupUI()
        setupUIFunctionality()
    }
    
    func removeLoggedOutViewControllers() {
        if navigationController?.viewControllers.count == 2 {
            navigationController?.viewControllers.remove(at: 0)
        }
        
        else if navigationController?.viewControllers.count == 3 {
            navigationController?.viewControllers.remove(at: 0)
            navigationController?.viewControllers.remove(at: 1)
        }
    }
    
    func setupUI() {
        navigationItem.title = "Home"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPress))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(cartButtonPress))
        
        view.backgroundColor = .white
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make -> Void in
            make.leading.top.width.height.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUIFunctionality() {
        homeViewModel.homeViewModelDelegate = self
        
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        homeView.tableViewButton.addTarget(self, action: #selector(tableViewButtonPress(sender:)), for: .touchUpInside)
        homeView.collectionViewButton.addTarget(self, action: #selector(collectionViewButtonPress(sender:)), for: .touchUpInside)
        
        homeView.searchTextField.addTarget(self, action: #selector(textFieldFocus(sender:)), for: .editingDidBegin)
        homeView.searchTextField.addTarget(self, action: #selector(textFieldUnfocus(sender:)), for: .editingDidEnd)
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: homeView.searchTextField)
            .map { _ in self.homeView.searchTextField.text! }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { searchString in self.homeViewModel.getSearchedProducts(searchString: searchString)})
            .store(in: &cancellables)
        
        homeView.categoriesTableView.dataSource = self
        homeView.categoriesTableView.delegate = self
        homeView.categoriesTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        
        homeView.collectionLayoutMenuCollectionView.dataSource = self
        homeView.collectionLayoutMenuCollectionView.delegate = self
        homeView.collectionLayoutMenuCollectionView.register(CollectionLayoutMenuCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionLayoutMenuCell")
        
        homeView.collectionLayoutProductsCollectionView.dataSource = self
        homeView.collectionLayoutProductsCollectionView.delegate = self
        homeView.collectionLayoutProductsCollectionView.register(CategoryProductCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryProductCell")
        
        homeView.searchedProductsCollectionView.dataSource = self
        homeView.searchedProductsCollectionView.delegate = self
        homeView.searchedProductsCollectionView.register(SearchProductCollectionViewCell.self, forCellWithReuseIdentifier: "SearchProductCell")
        homeView.searchedProductsCollectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        
        homeView.productsCollectionView.dataSource = self
        homeView.productsCollectionView.delegate = self
        homeView.productsCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
    }
}

extension HomeViewController {
    @objc func hideKeyboard() {
        homeView.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        homeView.scrollView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-sender.getKeyboardHeightEnd() - 2 * homeView.verticalOffset + keyboardHeightOffset)
        }
        
        homeView.productsCollectionView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(homeView.horizontalOffset)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
            make.height.equalTo(0)
        }
    }
    
    @objc func keyboardWillHide() {
        homeView.scrollView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        homeView.productsCollectionView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(homeView.horizontalOffset)
            make.height.equalTo(homeView.productsCollectionViewHeight)
            make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
            make.bottom.equalToSuperview().offset(-homeView.verticalOffset)
        }
    }
    
    @objc func textFieldFocus(sender: CustomTextField) {
        sender.updateBackgroundColor(backgroundColor: .systemGray3)
    }
    
    @objc func textFieldUnfocus(sender: CustomTextField) {
        sender.updateBackgroundColor(backgroundColor: .systemGray4)
    }
    
    @objc func logoutButtonPress() {
        homeView.endEditing(true)
        homeViewModel.removeToken()
    }
    
    @objc func cartButtonPress() {
        showCartModal()
    }
    
    @objc func tableViewButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        homeView.endEditing(true)
        homeView.searchTextField.text = ""
        
        homeViewModel.layoutChoice = 1
        
        homeView.tableViewButton.updateBackgroundColor(backgroundColor: .systemBlue)
        homeView.tableViewButton.updateTintColor(tintColor: .white)
        
        homeView.collectionViewButton.updateBackgroundColor(backgroundColor: .systemGray4)
        homeView.collectionViewButton.updateTintColor(tintColor: .systemBlue)
        
        homeView.collectionLayoutView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.searchedProductsCollectionView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.categoriesTableView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(homeView.horizontalOffset)
            make.top.equalTo(homeView.displayMenuView.snp.bottom).offset(homeView.verticalOffset)
            make.bottom.equalTo(homeView.productsCollectionView.snp.top).offset(-homeView.verticalOffset)
            make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
        }
    }
    
    @objc func collectionViewButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        homeViewModel.getCategoryProducts()
        
        homeView.endEditing(true)
        homeView.searchTextField.text = ""
        
        homeViewModel.layoutChoice = 2
        
        homeView.collectionViewButton.updateBackgroundColor(backgroundColor: .systemBlue)
        homeView.collectionViewButton.updateTintColor(tintColor: .white)
        
        homeView.tableViewButton.updateBackgroundColor(backgroundColor: .systemGray4)
        homeView.tableViewButton.updateTintColor(tintColor: .systemBlue)
        
        homeView.categoriesTableView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.searchedProductsCollectionView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.collectionLayoutView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(homeView.horizontalOffset)
            make.top.equalTo(homeView.displayMenuView.snp.bottom).offset(homeView.verticalOffset)
            make.bottom.equalTo(homeView.productsCollectionView.snp.top).offset(-homeView.verticalOffset)
            make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
        }
    }
    
    @objc func productCategoryCellPress(sender: CustomTapGestureRecognizer) {
        homeView.endEditing(true)
        sender.view?.onViewPressAnimation()
        showCategoryProductsModal(categoryName: homeViewModel.productsCategories[sender.tag].lowercased())
    }
    
    @objc func productCategoryMenuCellPress(sender: CustomTapGestureRecognizer) {
        homeView.endEditing(true)
        sender.view?.onViewPressAnimation()
        homeViewModel.selectedCategoryIndex = sender.tag
        homeViewModel.getCategoryProducts()
        homeView.collectionLayoutMenuCollectionView.animatedReload()
    }
    
    @objc func decreaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CategoryProductCollectionViewCell = homeView.collectionLayoutProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CategoryProductCollectionViewCell
        
        cell.quantityLabel.text = "\(Int(cell.quantityLabel.text!)! - 1)"
        cell.decreaseQuantityButton.isEnabled = Int(cell.quantityLabel.text!)! == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = Int(cell.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
    }
    
    @objc func increaseQuantityButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CategoryProductCollectionViewCell = homeView.collectionLayoutProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CategoryProductCollectionViewCell
        
        cell.quantityLabel.text = "\(Int(cell.quantityLabel.text!)! + 1)"
        cell.decreaseQuantityButton.isEnabled = Int(cell.quantityLabel.text!)! == 1 ? false : true
        cell.decreaseQuantityButton.backgroundColor = Int(cell.quantityLabel.text!)! == 1 ? .systemGray2 : .systemBlue
    }
    
    @objc func addCategoryProductButtonPress(sender: UIButton) {
        sender.onButtonPressAnimation()
        
        let cell: CategoryProductCollectionViewCell = homeView.collectionLayoutProductsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CategoryProductCollectionViewCell
        
        homeViewModel.updateCart(productId: homeViewModel.categoryProducts[sender.tag].id, productQuantity: Int(cell.quantityLabel.text!)!, productRow: sender.tag)
    }
    
    @objc func searchProductCellPress(sender: CustomTapGestureRecognizer) {
        homeView.endEditing(true)
        sender.view?.onViewPressAnimation()
        showProductModal(product: homeViewModel.searchedProducts[sender.tag])
    }
    
    @objc func productCellPress(sender: CustomTapGestureRecognizer) {
        sender.view?.onViewPressAnimation()
        showProductModal(product: homeViewModel.products[sender.tag])
    }
}

extension HomeViewController {
    func showCartModal() {
        let cartViewController: CartViewController = CartViewController(cartData: homeViewModel.cartData)
        
        cartViewController.cartViewModel.cartViewModelParentDelegate = self
        
        present(cartViewController, animated: true)
    }
    
    func showCategoryProductsModal(categoryName: String) {
        let categoryProductsViewController: CategoryProductsViewController = CategoryProductsViewController(cartData: homeViewModel.cartData, categoryName: categoryName)
        
        categoryProductsViewController.categoryProductsViewModel.categoryProductsViewModelParentDelegate = self
        
        present(categoryProductsViewController, animated: true)
    }
    
    func showProductModal(product: ProductModel) {
        let productViewController: ProductViewController = ProductViewController(cartData: homeViewModel.cartData, product: product)
        
        productViewController.productViewModel.productViewModelParentDelegate = self
        
        present(productViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.productsCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.setupUI()
        
        let tapRecognizer: CustomTapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(productCategoryCellPress(sender:)))
        tapRecognizer.tag = indexPath.row
        cell.contentView.addGestureRecognizer(tapRecognizer)
        
        cell.nameLabel.text = homeViewModel.productsCategories[indexPath.row].replacingOccurrences(of: "-", with: " ", options: .literal, range: nil).capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return categoryCellHeight
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case homeView.collectionLayoutProductsCollectionView:
                return homeViewModel.categoryProducts.count
            case homeView.collectionLayoutMenuCollectionView:
                return homeViewModel.productsCategories.count
            case homeView.searchedProductsCollectionView:
                return homeViewModel.searchedProducts.count == 0 ? 1 : homeViewModel.searchedProducts.count
            case homeView.productsCollectionView:
                return homeViewModel.products.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case homeView.collectionLayoutProductsCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryProductCell", for: indexPath) as! CategoryProductCollectionViewCell
                
                cell.setupUI()
                
                let tapRecognizer: CustomTapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(productCellPress(sender:)))
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
                
                cell.categoryProductNameValueLabel.text = homeViewModel.categoryProducts[indexPath.row].title
                cell.categoryProductBrandValueLabel.text = homeViewModel.categoryProducts[indexPath.row].brand
                cell.categoryProductRatingValueLabel.text = String(format: "%.2f", homeViewModel.categoryProducts[indexPath.row].rating)
                
                let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", homeViewModel.categoryProducts[indexPath.row].price))
                attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
                cell.categoryProductOldPriceValueLabel.attributedText = attributedOldPriceString
                
                cell.categoryProductNewPriceValueLabel.text = String(format: "%.2f€", homeViewModel.categoryProducts[indexPath.row].price * (100 - homeViewModel.categoryProducts[indexPath.row].discountPercentage) / 100)
                cell.quantityLabel.text = "\(1)"
                
                guard let imageURL = URL(string: homeViewModel.categoryProducts[indexPath.row].thumbnail) else {
                    cell.categoryProductImageView.image = UIImage(systemName: "photo")
                    return cell
                }
                
                cell.categoryProductImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.categoryProductImageView.sd_imageIndicator?.startAnimatingIndicator()
                cell.categoryProductImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
                
                return cell
            case homeView.collectionLayoutMenuCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionLayoutMenuCell", for: indexPath) as! CollectionLayoutMenuCollectionViewCell
                
                cell.setupUI()
            
                if indexPath.row == homeViewModel.selectedCategoryIndex {
                    cell.contentView.backgroundColor = .systemBlue
                    cell.categoryNameLabel.textColor = .white
                }
                
                else {
                    cell.contentView.backgroundColor = .systemGray3
                    cell.categoryNameLabel.textColor = .black
                }
            
                let tapRecognizer: CustomTapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(productCategoryMenuCellPress(sender:)))
                tapRecognizer.tag = indexPath.row
                cell.contentView.addGestureRecognizer(tapRecognizer)
            
                cell.categoryNameLabel.text = homeViewModel.productsCategories[indexPath.row].uppercased()
            
                return cell
            case homeView.searchedProductsCollectionView:
                if homeViewModel.searchedProducts.count == 0 {
                    let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCollectionViewCell
                    
                    emptyCell.setupUI()
                    
                    return emptyCell
                }
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchProductCell", for: indexPath) as! SearchProductCollectionViewCell
                
                cell.setupUI()
            
                let tapRecognizer: CustomTapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(searchProductCellPress(sender:)))
                tapRecognizer.tag = indexPath.row
                cell.contentView.addGestureRecognizer(tapRecognizer)
            
                cell.searchProductNameValueLabel.text = homeViewModel.searchedProducts[indexPath.row].title
                cell.searchProductBrandValueLabel.text = homeViewModel.searchedProducts[indexPath.row].brand
                cell.searchProductRatingValueLabel.text = String(format: "%.2f", homeViewModel.searchedProducts[indexPath.row].rating)
                
                let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", homeViewModel.searchedProducts[indexPath.row].price))
                attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
                cell.searchProductOldPriceValueLabel.attributedText = attributedOldPriceString
                
                cell.searchProductNewPriceValueLabel.text = String(format: "%.2f€", homeViewModel.searchedProducts[indexPath.row].price * (100 - homeViewModel.searchedProducts[indexPath.row].discountPercentage) / 100)
            
                guard let imageURL = URL(string: homeViewModel.searchedProducts[indexPath.row].thumbnail) else {
                    cell.searchProductImageView.image = UIImage(systemName: "photo")
                    return cell
                }
                
                cell.searchProductImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.searchProductImageView.sd_imageIndicator?.startAnimatingIndicator()
                cell.searchProductImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
                
                return cell
            case homeView.productsCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
                
                cell.setupUI()
            
                let tapRecognizer: CustomTapGestureRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(productCellPress(sender:)))
                tapRecognizer.tag = indexPath.row
                cell.contentView.addGestureRecognizer(tapRecognizer)
            
                cell.productNameValueLabel.text = homeViewModel.products[indexPath.row].title
            
                let attributedOldPriceString: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f€", homeViewModel.products[indexPath.row].price))
                attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedOldPriceString.length))
                cell.productOldPriceValueLabel.attributedText = attributedOldPriceString
            
                cell.productNewPriceValueLabel.text = String(format: "%.2f€", homeViewModel.products[indexPath.row].price * (100 - homeViewModel.products[indexPath.row].discountPercentage) / 100)
            
                guard let imageURL = URL(string: homeViewModel.products[indexPath.row].thumbnail) else {
                    cell.productImageView.image = UIImage(systemName: "photo")
                    return cell
                }
                
                cell.productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.productImageView.sd_imageIndicator?.startAnimatingIndicator()
                cell.productImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
                
                return cell
            default:
                return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            case homeView.collectionLayoutProductsCollectionView:
                return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2 + collectionLayoutProductCellHeight)
            case homeView.collectionLayoutMenuCollectionView:
                return CGSize(width: 1, height: collectionView.frame.height)
            case homeView.searchedProductsCollectionView:
                return CGSize(width: collectionView.frame.width, height: searchedProductCellHeight)
            case homeView.productsCollectionView:
                return CGSize(width: collectionView.frame.height / 2, height: collectionView.frame.height)
            default:
                return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
            case homeView.productsCollectionView:
                if indexPath.row == homeViewModel.products.count - 3 {
                    homeViewModel.getAllProducts()
                }
            default:
                break
        }
    }
    
}

extension HomeViewController: CartViewModelParentDelegate, CategoryProductsViewModelParentDelegate, ProductViewModelParentDelegate {
    func updateCartData(cartData: CartModel) {
        homeViewModel.cartData = cartData
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func navigateToLogin() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func updateCategoriesTable() {
        homeView.categoriesTableView.animatedReload()
        homeView.collectionLayoutMenuCollectionView.animatedReload()
    }
    
    func updateCollectionLayoutProductsCollection() {
        homeView.collectionLayoutProductsCollectionView.animatedReload()
    }
    
    func updateProductsCollection() {
        homeView.productsCollectionView.animatedReload()
    }
    
    func showSearchedProducts() {
        homeView.tableViewButton.updateBackgroundColor(backgroundColor: .systemGray4)
        homeView.tableViewButton.updateTintColor(tintColor: .systemBlue)
        
        homeView.collectionViewButton.updateBackgroundColor(backgroundColor: .systemGray4)
        homeView.collectionViewButton.updateTintColor(tintColor: .systemBlue)
        
        homeView.searchedProductsCollectionView.snp.remakeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(homeView.horizontalOffset)
            make.top.equalTo(homeView.displayMenuView.snp.bottom).offset(homeView.verticalOffset)
            make.bottom.equalTo(homeView.productsCollectionView.snp.top).offset(-homeView.verticalOffset)
            make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
        }
        
        homeView.categoriesTableView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.collectionLayoutView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.searchedProductsCollectionView.animatedReload()
    }
    
    func hideSearchedProducts() {
        if homeViewModel.layoutChoice == 1 {
            homeView.tableViewButton.updateBackgroundColor(backgroundColor: .systemBlue)
            homeView.tableViewButton.updateTintColor(tintColor: .white)
        }
        
        else {
            homeView.collectionViewButton.updateBackgroundColor(backgroundColor: .systemBlue)
            homeView.collectionViewButton.updateTintColor(tintColor: .white)
        }
        
        if homeViewModel.layoutChoice == 1 {
            homeView.categoriesTableView.snp.remakeConstraints { make -> Void in
                make.leading.equalToSuperview().offset(homeView.horizontalOffset)
                make.top.equalTo(homeView.displayMenuView.snp.bottom).offset(homeView.verticalOffset)
                make.bottom.equalTo(homeView.productsCollectionView.snp.top).offset(-homeView.verticalOffset)
                make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
            }
        }
        
        else {
            homeView.collectionLayoutView.snp.remakeConstraints { make -> Void in
                make.leading.equalToSuperview().offset(homeView.horizontalOffset)
                make.top.equalTo(homeView.displayMenuView.snp.bottom).offset(homeView.verticalOffset)
                make.bottom.equalTo(homeView.productsCollectionView.snp.top).offset(-homeView.verticalOffset)
                make.width.equalToSuperview().offset(-2 * homeView.horizontalOffset)
            }
        }
        
        homeView.searchedProductsCollectionView.snp.remakeConstraints { make -> Void in
            make.height.equalTo(0)
        }
        
        homeView.categoriesTableView.animatedReload()
    }
    
    func showErrorAlert(message: String) {
        let alertController: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
