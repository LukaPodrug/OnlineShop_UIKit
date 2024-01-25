//
//  APIModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import Foundation

struct GetCartModel: Decodable {
    let carts: [CartModel]
}

struct GetProductsModel: Decodable {
    let products: [ProductModel]
    let total: Int
    let skip: Int
    let limit: Int
}
