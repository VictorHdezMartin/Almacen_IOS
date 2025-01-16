//
//  CategoriasProvider.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import Foundation

class CategoriasProvider {
    
    static func findCategoriasBy(name: String) async throws -> [CategoriaClass] {
        let url = URL(string: "https://dummyjson.com/products/categories\(name)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(CategoriasResponse.self, from: data)
        return result.results
    }
    
    static func findCategoriasBy(id: String) async throws -> CategoriaClass {
        let url = URL(string: "https://dummyjson.com/products/categories\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(CategoriaClass.self, from: data)
        return result
    }
    
    static func findAllCategorias() async throws -> [String] {
        let url = URL(string: "https://dummyjson.com/products/category-list")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([String].self, from: data)
        return result
    }    
}
