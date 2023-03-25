//
//  UserViewModel.swift
//  MVVMDemo
//
//  Created by Balaganesh on 23/03/23.
//

import Foundation
import Combine

class UserViewModel {
    
    @Published var users: [User] = []
    
    init() {
        fetchAllUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                self?.users = []
                print(error)
            }
        }
    }
    
    private func fetchAllUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        
        let url = "https://jsonplaceholder.typicode.com/users"
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let usersData = data else {
                completion(.failure(error!))
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: usersData)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
