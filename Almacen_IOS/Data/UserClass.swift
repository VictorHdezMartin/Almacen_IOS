//
//  UserClass.swift
//  Almacen_IOS
//
//  Created by Tardes on 17/1/25.
//

import Foundation

struct user: Codable {
    var id: String
    var username: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var birdthday: Date?
    var loginProvider: LoginProvider
    var imagenUser: String?
}

struct Gender: Codable {
    
}

struct LoginProvider: Codable {
    
    
    
}
