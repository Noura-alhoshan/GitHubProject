//
//  ViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview1: UITableView!
    
    private var viewModel = GitHubViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
        // Do any additional setup after loading the view.
    }
    
    private func loadUsersData() {
        viewModel.shouldRefreahUI.bind { willShow in
            guard willShow else { return }
        }
            
        viewModel.getUsersData { [weak self] in
            self?.tableview1.dataSource = self
            self?.tableview1.delegate = self
            self?.tableview1.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UsersTableViewCell
        
        let user = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(user)
        
        return cell
    }

}

