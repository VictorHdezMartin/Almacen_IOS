//
//  ProductosProvider.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import Foundation

class ProductosProvider {
    
    static func findAllProductos(categoria: String) async throws -> [ProductosClass] {
        let url = URL(string: "https://dummyjson.com/products/category/\(categoria)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductosResponse.self, from: data)
        return result.products
    }
}

struct ProductosResponse: Codable {
    let products: [ProductosClass]
}

struct ProductosClass: Codable {
    var id: Int
    var title: String?
    var thumbnail: String
}
