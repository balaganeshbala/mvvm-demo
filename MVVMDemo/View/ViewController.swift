//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Balaganesh on 23/03/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    var cancellables: Set<AnyCancellable> = []
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        cancellables.insert(userViewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.users = users
                self?.tableView.reloadData()
            })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") ?? UITableViewCell()
        cell.textLabel?.text = user.name
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = users[indexPath.item]
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.viewModel = DetailViewModel(user: selectedUser)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

