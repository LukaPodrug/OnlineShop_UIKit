//
//  CategoryProductsViewModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import Foundation
import Combine

protocol CategoryProductsViewModelParentDelegate: AnyObject {
    func updateCartData(cartData: CartModel)
}

protocol CategoryProductsViewModelDelegate: AnyObject {
    func updateCategoryProductsCollection()
    func showErrorAlert(message: String)
}

class CategoryProductsViewModel {
    var cancellables = Set<AnyCancellable>()
    
    var categoryProductsViewModelParentDelegate: CategoryProductsViewModelParentDelegate?
    var categoryProductsViewModelDelegate: CategoryProductsViewModelDelegate?
    
    var cartData: CartModel
    let categoryName: String
    var categoryProducts: [ProductModel]
    
    init(cartData: CartModel, categoryName: String) {
        self.cancellables = Set<AnyCancellable>()
        
        self.cartData = cartData
        self.categoryName = categoryName
        self.categoryProducts = []
        
        getCategoryProducts()
    }
}

extension CategoryProductsViewModel {
    func getCategoryProducts() {
        APIManager.shared.getCategoryProducts(categoryName: categoryName)
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
        categoryProductsViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleGetCategoryProductsSuccess(categoryProducts: [ProductModel]) {
        self.categoryProducts = categoryProducts
        categoryProductsViewModelDelegate?.updateCategoryProductsCollection()
    }
}

extension CategoryProductsViewModel {
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
        
        categoryProductsViewModelDelegate?.updateCategoryProductsCollection()
        categoryProductsViewModelParentDelegate?.updateCartData(cartData: cartData)
    }
}
