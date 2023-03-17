//
//  ProductsModel.swift
//  EZV_Assignment
//
//  Created by Ferry Julian on 17/03/23.
//

import Foundation

struct Products: Codable {
    let products: [DataProduct]?
}

struct DataProduct: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}
