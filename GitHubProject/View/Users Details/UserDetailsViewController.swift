//
//  UserDetailsViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 04/01/2023.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var viewModel: UserDetailsViewModel?
    
    // MARK: - IBOutlet

    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followersLable: UILabel!
    @IBOutlet weak var publicRepoLable: UILabel!
    @IBOutlet weak var publicRepo: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var header: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        bindloading()
        viewModel?.getUsersDetails()
        viewModel?.getReposData()
        bindUsersDatails()
        bindReposData()
    }
    
    private func bindUsersDatails() {
        viewModel?.didUsersDetailsLoad.bind { willShow in // end user in bind insted
            guard let user = willShow else { return }
            self.followers.text = "\(user.followers ??  00)"
            self.followersLable.text = "Followers: "
            self.publicRepoLable.text = "Public Repositories: "
            self.publicRepo.text = "\(user.publicRepos ??  00)"
            self.header.text = "List Of Repositories: "
        }
    }
    
    private func bindReposData() {
        viewModel?.didReposDataLoad.bind { willShow in
            guard willShow else { return }
            self.tableview.reloadData()
        }
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
    
    func didSelectRow(at indexPath: IndexPath) {
        let subview = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = subview.instantiateViewController(withIdentifier: "ForksUsersViewController") as? ForksUsersViewController {
            viewController.viewModel = ForksUsersViewModel(forkUser: (viewModel?.getRepo(indexPath: indexPath))!) // change
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rowsNumber ?? 00
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ReposTableViewCell
        
        guard let repo = viewModel?.getRepo(indexPath: indexPath) else { return cell }
        cell.setCellWithValuesOf(repo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath)
    }
    
}
    
    
    
    

