//
//  DetailViewModel.swift
//  MVVMDemo
//
//  Created by Balaganesh on 24/03/23.
//

import Foundation

class DetailViewModel {
    
    @Published var userName: String
    @Published var userAddress: String
    
    init(user: User) {
        userName = user.name
        userAddress = "\(user.address.street), \(user.address.suite), \(user.address.city) - \(user.address.zipcode)."
    }
}
