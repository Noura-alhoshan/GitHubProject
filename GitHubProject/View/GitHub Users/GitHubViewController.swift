//
//  GitHubViewController.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import UIKit

class GitHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel = GitHubViewModel()
    
    private var tableView: UITableView!
    
    private func setTableView() {
                tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
                tableView.register(TwoTitleAndAvatarTableViewCell.nib(), forCellReuseIdentifier: TwoTitleAndAvatarTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        bindloading()
        viewModel.getUsersData()
        bindUsersData()
        }
    
    private func bindUsersData() {
            viewModel.didUsersLoad.bind { [weak self] willShow in
                self?.tableView.reloadData()
            guard willShow else { return }
        }
    }
    
    private func bindloading() {
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
            vc.viewModel = UserDetailsViewModel(user: viewModel.getUser(indexPath: indexPath))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TwoTitleAndAvatarTableViewCell.identifier, for: indexPath)
     as! TwoTitleAndAvatarTableViewCell
    
        cell.configure(representable: viewModel.cellViewModel(indexPath: indexPath))
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
      return "GitHub Users"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            didSelectRow(at: indexPath)
    }
}
