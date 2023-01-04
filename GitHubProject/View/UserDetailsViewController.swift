//
//  UserDetailsViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 04/01/2023.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController {
    var viewModel: UserDetailsViewModel!
    
    @IBOutlet weak var test: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsersData()
    }
    
    private func loadUsersData() {
        viewModel.shouldRefreahUI.bind { willShow in
            guard willShow else { return }
            //self.imageshare.kf.setImage(with: self.viewModel.url)
            //self.test.text = self.viewModel.name
        }
        }
    
    
    
    }
    
    
    
    

