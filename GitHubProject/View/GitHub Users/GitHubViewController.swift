//
//  GitHubViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import UIKit

class GitHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var viewModel = GitHubViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UsersTableViewCell.nib(), forCellReuseIdentifier: UsersTableViewCell.identifier)

        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        loading()
        viewModel.getUsersData()
        bindUsersData()
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func bindUsersData() {
            viewModel.didUsersLoad.bind { [weak self] willShow in
            guard willShow else { return }
                self?.tableView.reloadData()
                self?.tableView.dataSource = self
                self?.tableView.delegate = self
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
    
    func didSelectRow(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subview = UIStoryboard(name: "UserDetailsViewController", bundle: nil)
        if let vc = subview.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController {
            vc.viewModel = UserDetailsViewModel(user: viewModel.cellForRowAt(indexPath: indexPath))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath)
     as! UsersTableViewCell
        
       let user = viewModel.cellForRowAt(indexPath: indexPath)
       cell.setCellWithValuesOf(user)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //prse
            didSelectRow(at: indexPath)
    }
}
