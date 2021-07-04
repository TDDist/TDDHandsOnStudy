//
//  ProductCellTableViewCell.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import UIKit

final class ProductCell: UITableViewCell, ReusableView {
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var productCodeLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var sellingPriceLabel: UILabel!
    
    func update(with productViewModel: ProductViewModel) {
        let product = productViewModel.product
        
        supplierNameLabel.text = product.supplierName
        productCodeLabel.text = product.productCode
        productNameLabel.text = product.productName
        listPriceLabel.text = productViewModel.listPriceText
        discountLabel.text = productViewModel.discountText
        sellingPriceLabel.text = productViewModel.sellingPriceText
    }
}
