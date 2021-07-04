//
//  ViewController.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import UIKit

final class InventoryViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var productTable: UITableView!
    private let inventoryViewModel = InventoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObserver()
        configureProductTable()
        fetchDataFromJSON()
    }
    
    private func configureProductTable() {
        self.productTable.dataSource = inventoryViewModel
        self.productTable.delegate = self
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateProductTable),
            name: InventoryViewModel.Notification.productsUpdated,
            object: inventoryViewModel
        )
    }
    
    @objc private func updateProductTable() {
        DispatchQueue.main.async {
            self.productTable.reloadData()
        }
    }
    
    private func fetchDataFromJSON() {
        guard let productsJsonData = Data.readJSON(for: "Products") else { return }
        guard let products = try? JSONDecoder().decode([Product].self, from: productsJsonData) else { return }
        
        self.inventoryViewModel.update(with: products)
    }
}

