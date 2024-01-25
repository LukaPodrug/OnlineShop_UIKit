//
//  ProductViewModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 24.01.2024..
//

import Foundation

protocol ProductViewModelParentDelegate: AnyObject {
    func updateCartData(cartData: CartModel)
}

protocol ProductViewModelDelegate: AnyObject {
    func updateProductModal()
}

class ProductViewModel {
    var productViewModelParentDelegate: ProductViewModelParentDelegate?
    var productViewModelDelegate: ProductViewModelDelegate?
    
    var cartData: CartModel
    var product: ProductModel
    
    init(cartData: CartModel, product: ProductModel) {
        self.cartData = cartData
        self.product = product
    }
}

extension ProductViewModel {
    func updateCart(productQuantity: Int) {
        var productIndex: Int = -1
        var oldProductQuantity: Int = 0
        var productPrice: Float = 0
        var productDiscountedPrice: Float = 0
        
        for (index, cartProduct) in cartData.products.enumerated() {
            if cartProduct.id == product.id {
                productIndex = index
                oldProductQuantity = cartProduct.quantity
                productPrice = cartProduct.price
                productDiscountedPrice = cartProduct.discountedPrice / Float(cartProduct.quantity)
            }
        }
        
        if productIndex == -1 {
            cartData.products.insert(CartProductModel(id: product.id, title: product.title, price: product.price, quantity: 0, total: 0, discountPercentage: product.discountPercentage, discountedPrice: 0, thumbnail: product.thumbnail), at: 0)
            
            productIndex = 0
            oldProductQuantity = 0
            productPrice = product.price
            productDiscountedPrice = product.price * (100 - product.discountPercentage) / 100
            
            cartData.totalProducts = cartData.totalProducts + 1
        }
        
        cartData.products[productIndex].quantity = oldProductQuantity + productQuantity
        cartData.products[productIndex].total = Float(oldProductQuantity + productQuantity) * productPrice
        cartData.products[productIndex].discountedPrice = Float(oldProductQuantity + productQuantity) * productDiscountedPrice
        cartData.total = cartData.total + Float(productQuantity) * productPrice
        cartData.discountedTotal = cartData.discountedTotal + Float(productQuantity) * productDiscountedPrice
        cartData.totalQuantity = cartData.totalQuantity + productQuantity
        
        productViewModelDelegate?.updateProductModal()
        productViewModelParentDelegate?.updateCartData(cartData: cartData)
    }
}

