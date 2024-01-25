//
//  ProductModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 18.01.2024..
//

import Foundation

struct ProductModel: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Float
    let discountPercentage: Float
    let rating: Float
    let stock: Float
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

struct CartProductModel: Decodable {
    let id: Int
    let title: String
    let price: Float
    var quantity: Int
    var total: Float
    let discountPercentage: Float
    var discountedPrice: Float
    let thumbnail: String
}
