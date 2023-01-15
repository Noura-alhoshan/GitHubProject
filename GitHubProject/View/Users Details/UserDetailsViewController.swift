//
//  UserDetailsViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 04/01/2023.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var viewModel: UserDetailsViewModel!
    
    // MARK: - IBOutlet

    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followersLable: UILabel!
    @IBOutlet weak var publicRepoLable: UILabel!
    @IBOutlet weak var publicRepo: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var header: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading()
        loading2()
        viewModel.getUsersDetails()
        viewModel.getReposData()
        bindUsersDatails()
        bindReposData()
    }
    
    private func bindUsersDatails() {
        viewModel.didUsersDetailsLoad.bind { willShow in
            guard willShow else { return }
            self.followers.text = self.viewModel.follwers
            self.followersLable.text = "Followers: "
            self.publicRepoLable.text = "Public Repositories: "
            self.publicRepo.text = self.viewModel.publicRepo
            self.header.text = "List Of Repositories: "
        }
        }
    
    private func bindReposData() {
        viewModel.didReposDataLoad.bind { willShow in
            guard willShow else { return }
            self.tableview.dataSource = self
            self.tableview.delegate = self
            self.tableview.reloadData()
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
    
    private func loading2(){
        viewModel.isloading.bind { isloading in
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
            viewController.viewModel = ForksUsersViewModel(forkUser: viewModel.cellForRowAt(indexPath: indexPath))
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ReposTableViewCell
        
        let repo = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(repo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath)
    }
    
}
    
    
    
    

