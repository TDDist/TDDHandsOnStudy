//
//  ProductViewModel.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import UIKit

final class InventoryViewModel: NSObject, UITableViewDataSource {
    enum Notification {
        static let productsUpdated = Foundation.Notification.Name("productsUpdated")
    }
    
    private var productViewModels = [ProductViewModel]() {
        didSet { NotificationCenter.default.post(name: Notification.productsUpdated, object: self) }
    }

    func update(with products: [Product]) {
        self.productViewModels = products.map { ProductViewModel(product: $0)}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else { return UITableViewCell() }
        
        let productViewModel = productViewModels[indexPath.row]
        productCell.update(with: productViewModel)
        
        return productCell
    }
}
