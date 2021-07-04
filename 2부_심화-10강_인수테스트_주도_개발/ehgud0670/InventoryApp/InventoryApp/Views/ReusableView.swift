//
//  ReusableView.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import UIKit

protocol ReusableView: AnyObject{ }

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
