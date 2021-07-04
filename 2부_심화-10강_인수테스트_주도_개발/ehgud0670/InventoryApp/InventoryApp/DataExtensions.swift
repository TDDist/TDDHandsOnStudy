//
//  DataExtensions.swift
//  InventoryApp
//
//  Created by sdean on 2021/07/04.
//

import Foundation

extension Data {
    static func readJSON(of bundle: Bundle = .main, for name: String) -> Data? {
        guard let url = bundle.url(
            forResource: name,
            withExtension: "json"
            ) else { return nil }
        return try? Data(contentsOf: url)
    }
}
