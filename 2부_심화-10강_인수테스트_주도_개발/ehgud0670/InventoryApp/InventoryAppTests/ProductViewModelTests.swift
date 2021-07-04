//
//  ProductViewModelTests.swift
//  InventoryAppTests
//
//  Created by sdean on 2021/07/04.
//

import XCTest
@testable import InventoryApp

class ProductViewModelTests: XCTestCase {
    func test_sellingPriceText_Success() {
        let product = Product(
            supplierName: "",
            productCode: "",
            productName: "",
            listPrice: 100000,
            discount: 10000
        )
        let productViewModel = ProductViewModel(product: product)
        
        XCTAssertEqual(productViewModel.sellingPriceText, "90000")
    }
}
