//
//  UsersTableViewCell.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation
import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var user: UILabel!

    func setCellWithValuesOf(_ User:GitHubUser) {
        updateUI(avatar: User.avatarURL, user: User.login)
    }
    
    private func updateUI( avatar: String?, user: String?) {
        self.user.text = user
        let url = URL(string:avatar ?? "")
        self.avatar.kf.setImage(with: url)
    }
}
