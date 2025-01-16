//
//  ProductosProvider.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import Foundation

class ProductosProvider {
    
    static func findAllProductos(categoria: String) async throws -> [ProductoClass] {
        let url = URL(string: "https://dummyjson.com/products/category/\(categoria)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductoResponse.self, from: data)
        return result.products
    }
}
