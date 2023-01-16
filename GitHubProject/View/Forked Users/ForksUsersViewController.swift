//
//  ForksUsersViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 05/01/2023.
//

import Foundation
import UIKit

class ForksUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var viewModel: ForksUsersViewModel?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UsersTableViewCell.nib(), forCellReuseIdentifier: UsersTableViewCell.identifier)

        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        bindloading()
        loadUsersData()
        viewModel?.getForksUsersData()
    }
    
    private func loadUsersData() {
        viewModel?.shouldRefreahUI.bind { willShow in
            guard willShow else { return }
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func bindloading() {
        viewModel?.isloading.bind { isloading in
            if isloading {
                self.startSpinner()
            } else {
                self.stopSpinner()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rowsNumber ?? 00    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as! UsersTableViewCell
        
        guard let user = viewModel?.cellForRowAt(indexPath: indexPath) else { return cell }

        cell.setCellWithValuesOfRepo(user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
      return "Forked Users"
    }
    
}
