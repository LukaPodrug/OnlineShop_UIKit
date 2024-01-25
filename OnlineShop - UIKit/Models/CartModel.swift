//
//  CartModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import Foundation

struct CartModel: Decodable {
    let id: Int
    var products: [CartProductModel]
    var total: Float
    var discountedTotal: Float
    let userId: Int
    var totalProducts: Int
    var totalQuantity: Int
}
