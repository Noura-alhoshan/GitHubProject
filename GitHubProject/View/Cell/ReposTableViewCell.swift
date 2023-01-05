//
//  ReposTableViewCell.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 04/01/2023.
//

import Foundation
import UIKit

class ReposTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var description1: UILabel!
    
    
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var repoNameLable: UILabel!
    @IBOutlet weak var repoName: UILabel!
    func setCellWithValuesOf(_ repo:GitHubRepo) {
        updateUI(name: repo.name, description: repo.description)
    }
    
    private func updateUI( name: String?, description: String?) {
    self.repoName.text = name
        self.repoNameLable.text = "Name:"
        self.description1.text = description
        self.descriptionLable.text = "Description:"

  
    }
    
}
