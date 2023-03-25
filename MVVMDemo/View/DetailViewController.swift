//
//  DetailViewController.swift
//  MVCDemo
//
//  Created by Balaganesh on 23/03/23.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancellables.insert(viewModel.$userName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userName in
                self?.nameLabel.text = userName
            })
        
        cancellables.insert(viewModel.$userAddress
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userAddress in
                self?.addressLabel.text = userAddress
            })
    }
}
