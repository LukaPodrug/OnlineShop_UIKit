//
//  HomeViewModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import Foundation
import Combine

protocol HomeViewModelDelegate: AnyObject {
    func navigateToLogin()
    func updateCategoriesTable()
    func updateCollectionLayoutProductsCollection()
    func updateProductsCollection()
    func showSearchedProducts()
    func hideSearchedProducts()
    func showErrorAlert(message: String)
}

class HomeViewModel {
    let productsPageLimit: Int = 10
    
    var cancellables = Set<AnyCancellable>()
    
    var homeViewModelDelegate: HomeViewModelDelegate?
    
    let userData: UserModel
    var cartData: CartModel
    var layoutChoice: Int
    var productsCategories: [String]
    var selectedCategoryIndex: Int
    var categoryProducts: [ProductModel]
    var searchedProducts: [ProductModel]
    var products: [ProductModel]
    var productsPage: Int
    var productsLoadMore: Bool
    
    init(userData: UserModel) {
        self.cancellables = Set<AnyCancellable>()
        
        self.userData = userData
        self.cartData = CartModel(id: 0, products: [], total: 0, discountedTotal: 0, userId: 0, totalProducts: 0, totalQuantity: 0)
        self.layoutChoice = 1
        self.productsCategories = []
        self.selectedCategoryIndex = 0
        self.categoryProducts = []
        self.searchedProducts = []
        self.products = []
        self.productsPage = 0
        self.productsLoadMore = true
        
        getUserCart()
        getProductsCategories()
        getAllProducts()
    }
}

extension HomeViewModel {
    func getUserCart() {
        APIManager.shared.getUserCart(userId: userData.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        self.handleGetUserCartFailure(message: error.localizedDescription)
                    default:
                        break
                }
            }
            receiveValue: { cartData in
                self.handleGetUserCartSuccess(cartData: cartData.carts.first!)
            }
            .store(in: &cancellables)
    }
    
    func handleGetUserCartFailure(message: String) {
        homeViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleGetUserCartSuccess(cartData: CartModel) {
        self.cartData = cartData
    }
    
    func getProductsCategories() {
        APIManager.shared.getProductsCategories()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        self.handleGetProductsCategoriesFailure(message: error.localizedDescription)
                    default:
                        break
                }
            }
            receiveValue: { productsCategories in
                self.handleGetProductsCategoriesSuccess(productsCategories: productsCategories)
            }
            .store(in: &cancellables)
    }
    
    func handleGetProductsCategoriesFailure(message: String) {
        homeViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleGetProductsCategoriesSuccess(productsCategories: [String]) {
        self.productsCategories = productsCategories
        homeViewModelDelegate?.updateCategoriesTable()
    }
    
    func getCategoryProducts() {
        APIManager.shared.getCategoryProducts(categoryName: productsCategories[selectedCategoryIndex])
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        self.handleGetCategoryProductsFailure(message: error.localizedDescription)
                    default:
                        break
                }
            }
            receiveValue: { categoryProductsData in
                self.handleGetCategoryProductsSuccess(categoryProducts: categoryProductsData.products)
            }
            .store(in: &cancellables)
    }
    
    func handleGetCategoryProductsFailure(message: String) {
        homeViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleGetCategoryProductsSuccess(categoryProducts: [ProductModel]) {
        self.categoryProducts = categoryProducts
        homeViewModelDelegate?.updateCollectionLayoutProductsCollection()
    }
    
    func getAllProducts() {
        if productsLoadMore == true {
            APIManager.shared.getAllProducts(limit: productsPageLimit, skip: productsPage * productsPageLimit)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        self.handleGetAllProductsFailure(message: error.localizedDescription)
                    default:
                        break
                    }
                }
            receiveValue: { allProductsData in
                self.handleGetAllProductsSuccess(products: allProductsData.products, total: allProductsData.total)
            }
            .store(in: &cancellables)
        }
    }
    
    func handleGetAllProductsFailure(message: String) {
        homeViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleGetAllProductsSuccess(products: [ProductModel], total: Int) {
        self.productsPage = self.productsPage + 1
        self.products.append(contentsOf: products)
        homeViewModelDelegate?.updateProductsCollection()

        if productsPage * productsPageLimit > total {
            productsLoadMore = false
        }
    }
    
    func getSearchedProducts(searchString: String) {
        if searchString != "" {
            APIManager.shared.getSearchedProducts(searchString: searchString)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        self.handleGetSearchedProductsFailure(message: error.localizedDescription)
                    default:
                        break
                    }
                }
                receiveValue: { searchedProductsData in
                    self.handleGetSearchedProductsSuccess(searchedProducts: searchedProductsData.products)
                }
                .store(in: &cancellables)
        }
        
        else {
            homeViewModelDelegate?.hideSearchedProducts()
        }
    }
    
    func handleGetSearchedProductsFailure(message: String) {
        homeViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleGetSearchedProductsSuccess(searchedProducts: [ProductModel]) {
        self.searchedProducts = searchedProducts
        homeViewModelDelegate?.showSearchedProducts()
    }
}

extension HomeViewModel {
    func removeToken() {
        KeychainManager.shared.remove(type: kSecClassGenericPassword, service: "token", account: "user") { result in
            switch result {
                case .failure(let error):
                    self.handleRemoveTokenFailure(message: error.localizedDescription)
                case .success:
                    self.handleRemoveTokenSuccess()
            }
        }
    }
    
    func handleRemoveTokenFailure(message: String) {
        homeViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleRemoveTokenSuccess() {
        homeViewModelDelegate?.navigateToLogin()
    }
}

extension HomeViewModel {
    func updateCart(productId: Int, productQuantity: Int, productRow: Int) {
        var productIndex: Int = -1
        var oldProductQuantity: Int = 0
        var productPrice: Float = 0
        var productDiscountedPrice: Float = 0
        
        for (index, cartProduct) in cartData.products.enumerated() {
            if cartProduct.id == productId {
                productIndex = index
                oldProductQuantity = cartProduct.quantity
                productPrice = cartProduct.price
                productDiscountedPrice = cartProduct.discountedPrice / Float(cartProduct.quantity)
            }
        }
        
        if productIndex == -1 {
            cartData.products.insert(CartProductModel(id: productId, title: categoryProducts[productRow].title, price: categoryProducts[productRow].price, quantity: 0, total: 0, discountPercentage: categoryProducts[productRow].discountPercentage, discountedPrice: 0, thumbnail: categoryProducts[productRow].thumbnail), at: 0)
            
            productIndex = 0
            oldProductQuantity = 0
            productPrice = categoryProducts[productRow].price
            productDiscountedPrice = categoryProducts[productRow].price * (100 - categoryProducts[productRow].discountPercentage) / 100
            
            cartData.totalProducts = cartData.totalProducts + 1
        }
        
        cartData.products[productIndex].quantity = oldProductQuantity + productQuantity
        cartData.products[productIndex].total = Float(oldProductQuantity + productQuantity) * productPrice
        cartData.products[productIndex].discountedPrice = Float(oldProductQuantity + productQuantity) * productDiscountedPrice
        cartData.total = cartData.total + Float(productQuantity) * productPrice
        cartData.discountedTotal = cartData.discountedTotal + Float(productQuantity) * productDiscountedPrice
        cartData.totalQuantity = cartData.totalQuantity + productQuantity
        
        homeViewModelDelegate?.updateCollectionLayoutProductsCollection()
    }
}
