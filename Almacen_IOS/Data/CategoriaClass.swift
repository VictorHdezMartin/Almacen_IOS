//
//  CategoriaClass.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import Foundation

struct CategoriasResponse: Codable {
    let results: [CategoriaClass]
}

struct CategoriaClass: Codable {
    var nCategoria: String               // nombre de la categoria
    var nImagen: String                  // imagen de la categoria
}

struct ProductoResponse: Codable {
    let products: [ProductoClass]
}

struct ProductoClass: Codable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var tags: [String]
    var brand: String
    var sku: String
    var weight: Double
    var dimensions: Dimensions
    var warrantyInformation: String
    var shippingInformation: String
    var availabilityStatus: String
    var reviews: [Review]
    var returnPolicy: String
    var minimumOrderQuantity: Int
    //var meta: [String]
    var images: [String]
    var thumbnail: String
}

struct Dimensions: Codable {
    var width: Double
    var height: Double
    var depth: Double
}

struct Review: Codable {
    var rating: Double
    var comment: String
    var date: String
    var reviewerName: String
    var reviewerEmail: String
}

struct Meta: Codable {
    var createdAt: String
    var updatedAt: String
    var barcode: String
    var qrCode: String
}


/*
 "id": 121,
  "title": "iPhone 5s",
  "description": "The iPhone 5s is a classic smartphone known for its compact design and advanced features during its release. While it's an older model, it still provides a reliable user experience.",
  "category": "smartphones",
  "price": 199.99,
  "discountPercentage": 11.85,
  "rating": 3.92,
  "stock": 65,
  "tags": [
    "smartphones",
    "apple"
  ],
  "brand": "Apple",
  "sku": "AZ1L68SM",
  "weight": 4,
  "dimensions": {
    "width": 8.49,
    "height": 25.34,
    "depth": 18.12
  },
  "warrantyInformation": "1 week warranty",
  "shippingInformation": "Ships in 1 week",
  "availabilityStatus": "In Stock",
  "reviews": [
    {
      "rating": 4,
      "comment": "Highly impressed!",
      "date": "2024-05-23T08:56:21.625Z",
      "reviewerName": "Wyatt Perry",
      "reviewerEmail": "wyatt.perry@x.dummyjson.com"
    },
    {
      "rating": 5,
      "comment": "Awesome product!",
      "date": "2024-05-23T08:56:21.625Z",
      "reviewerName": "Olivia Anderson",
      "reviewerEmail": "olivia.anderson@x.dummyjson.com"
    },
    {
      "rating": 4,
      "comment": "Highly recommended!",
      "date": "2024-05-23T08:56:21.625Z",
      "reviewerName": "Mateo Nguyen",
      "reviewerEmail": "mateo.nguyen@x.dummyjson.com"
    }
  ],
  "returnPolicy": "No return policy",
  "minimumOrderQuantity": 2,
  "meta": {
    "createdAt": "2024-05-23T08:56:21.625Z",
    "updatedAt": "2024-05-23T08:56:21.625Z",
    "barcode": "2903942810911",
    "qrCode": "https://assets.dummyjson.com/public/qr-code.png"
  },
  "images": [
    "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/1.png",
    "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/2.png",
    "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/3.png"
  ],
  "thumbnail": "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/thumbnail.png"
},
 
 
 
 
 */
