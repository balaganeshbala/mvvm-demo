//
//  UserModel.swift
//  MVCDemo
//
//  Created by Balaganesh on 23/03/23.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name, email, phone: String
    let address: Address
}

struct Address: Decodable {
    let street, suite, city, zipcode: String
}
