//
//  Product.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import Foundation

struct Product: Codable {
    let supplierName: String
    let productCode: String
    let productName: String
    let listPrice: Int
    let discount: Int
}
