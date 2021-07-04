//
//  ProductViewModel.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import Foundation

struct ProductViewModel {
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var listPriceText: String {
        return "\(product.listPrice)"
    }
    
    var discountText: String {
        return "\(product.discount)"
    }
    
    var sellingPriceText: String {
        return "\(product.listPrice - product.discount)"
    }
}
