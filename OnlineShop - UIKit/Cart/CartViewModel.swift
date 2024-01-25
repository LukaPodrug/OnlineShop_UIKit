//
//  CartViewModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import Foundation
import Combine

protocol CartViewModelParentDelegate: AnyObject {
    func updateCartData(cartData: CartModel)
}

protocol CartViewModelDelegate: AnyObject {
    func updateCartProductsCollection()
    func updateCartTotalView()
    func showErrorAlert(message: String)
}

class CartViewModel: ObservableObject {
    var cartViewModelParentDelegate: CartViewModelParentDelegate?
    var cartViewModelDelegate: CartViewModelDelegate?
    
    @Published var cartData: CartModel
    
    init(cartData: CartModel) {
        self.cartData = cartData
    }
}

extension CartViewModel {
    func updateCart(productId: Int, productQuantity: Int) {
        var productIndex: Int = 0
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
        
        cartData.products[productIndex].quantity = productQuantity
        cartData.products[productIndex].total = Float(productQuantity) * productPrice
        cartData.products[productIndex].discountedPrice = Float(productQuantity) * productDiscountedPrice
        cartData.total = cartData.total - Float(oldProductQuantity) * productPrice + Float(productQuantity) * productPrice
        cartData.discountedTotal = cartData.discountedTotal - Float(oldProductQuantity) * productDiscountedPrice + Float(productQuantity) * productDiscountedPrice
        cartData.totalQuantity = cartData.totalQuantity - oldProductQuantity + productQuantity
        
        if productQuantity == 0 {
            cartData.totalProducts = cartData.totalProducts - 1
            cartData.products.remove(at: productIndex)
        }
        
        cartViewModelDelegate?.updateCartProductsCollection()
        cartViewModelDelegate?.updateCartTotalView()
        cartViewModelParentDelegate?.updateCartData(cartData: cartData)
    }
}

extension CartViewModel {
    var validatedCart: AnyPublisher<Bool, Never> {
        return $cartData
            .map { cartData in
                if cartData.totalProducts == 0 {
                    return false
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
}
