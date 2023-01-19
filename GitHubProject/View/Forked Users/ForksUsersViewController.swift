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
        loadUsersData()
        viewModel?.getForksUsersData()
    }
    
    private func loadUsersData() {
        viewModel?.shouldRefreahUI.bind { willShow in
            guard willShow else { return }
            self.tableView.reloadData()
        }
    }
    
    private func bindloading() { // reuse 
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TwoTitleAndAvatarTableViewCell.identifier, for: indexPath) as! TwoTitleAndAvatarTableViewCell
        
        cell.configure(representable: viewModel?.cellViewModel(indexPath: indexPath) ?? TwoTitleAndAvatarCellViewModel(avatar: "", firstTitle: "", secondTitle: ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
      return "Forked Users"
    }
    
}
