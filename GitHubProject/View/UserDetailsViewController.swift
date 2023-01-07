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
    
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var followersLable: UILabel!
    
    @IBOutlet weak var publicRepoLable: UILabel!
    
    @IBOutlet weak var publicRepo: UILabel!
    
    
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var header: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUsersDetails()
        loadUsersDatails()
        loadReposData()
    }
    
    private func loadUsersDatails() {
        loading()
        viewModel.shouldRefreahUI.bind { willShow in
            guard willShow else { return }
            self.stopSpinner()
            self.followers.text = self.viewModel.follwers
            self.followersLable.text = "Followers: "
            self.publicRepoLable.text = "Public Repositories: "
            self.publicRepo.text = self.viewModel.publicRepo
            self.header.text = "List Of Repositories: "

        }
        }
    
    private func loadReposData() {
        loading()
        viewModel.shouldRefreahUIforRepo.bind { willShow in
            guard willShow else { return }
        }
        self.stopSpinner()
        viewModel.getReposData { [weak self] in
            self?.tableView2.dataSource = self
            self?.tableView2.delegate = self
            self?.tableView2.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ReposTableViewCell
        
        let repo = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(repo)
        
        return cell    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subview = UIStoryboard(name: "ForksUsersViewController", bundle: nil)
        if let vc = subview.instantiateViewController(withIdentifier: "ForksUsersViewController") as? ForksUsersViewController {
            vc.viewModel = ForksUsersViewModel(forkUser: viewModel.cellForRowAt(indexPath: indexPath))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
    
    
    
    

