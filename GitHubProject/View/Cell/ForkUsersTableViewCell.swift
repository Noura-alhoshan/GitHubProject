//
//  ForkUsersTableViewCell.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 07/01/2023.
//

import Foundation
import UIKit

class ForkUsersTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var avatar1: UIImageView!
    
    @IBOutlet weak var user1: UILabel!
    
    @IBOutlet weak var userName1: UILabel!
    
    
    
    
    func setCellWithValuesOf(_ User:GitHubRepo) {
        updateUI(avatar: User.owner?.avatarURL, user: User.owner?.login)
    }
    
    private func updateUI( avatar: String?, user: String?) {
        self.userName1.text = "Username: "
        self.user1.text = user
        let url = URL(string:avatar ?? "")
        self.avatar1.kf.setImage(with: url)
    }
}
