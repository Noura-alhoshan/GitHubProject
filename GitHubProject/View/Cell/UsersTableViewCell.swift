//
//  UsersTableViewCell.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 11/01/2023.
//

import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {
    
    static let identifier = "UsersTableViewCell"

    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    
    func setCellWithValuesOf(_ User:GitHubUser) {
        updateUI(avatar: User.avatarURL, user: User.login)
    }
    
    func setCellWithValuesOfRepo(_ User:GitHubRepo) {
        updateUI(avatar: User.owner?.avatarURL, user: User.owner?.login)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "UsersTableViewCell", bundle: nil)
    }
    
    private func updateUI( avatar: String?, user: String?) {
        self.user?.text = "Username: "
        self.userName?.text = user
        let url = URL(string:avatar ?? "")
        self.avatar?.kf.setImage(with: url)
    }
    
}
