//
//  ForksUsersViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 05/01/2023.
//

import Foundation
import UIKit

class ForksUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var viewModel: ForksUsersViewModel!
    
    
    @IBOutlet weak var tableView1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
    }
    
    
    private func loadUsersData() {
        self.startSpinner()
        viewModel.shouldRefreahUI.bind { willShow in
            guard willShow else { return }
            self.stopSpinner()
        }
            
        viewModel.getForksUsersData { [weak self] in
            self?.tableView1.dataSource = self
            self?.tableView1.delegate = self
            self?.tableView1.reloadData()
        }
    }
    
    private func loading(){
        viewModel.isloading.bind { isloading in
            if isloading {
                self.startSpinner()
            } else {
                self.stopSpinner()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! ForkUsersTableViewCell
        
        let user = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(user)
        
        return cell
    }
    
    
   
}
