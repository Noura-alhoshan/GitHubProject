//
//  UsersTableViewCell.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 11/01/2023.
//

import UIKit
import Kingfisher


// dont use kf // AFNetworking?
class TwoTitleAndAvatarTableViewCell: UITableViewCell {
    
    static let identifier = "TwoTitleAndAvatarTableViewCell"

    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    

    func configure(representable: TwoTitleAndAvatarCellViewModel) {
        self.firstTitle?.text = "Username: "
        self.secondTitle?.text = representable.title
        let url = URL(string:representable.avatar)
        self.avatar?.kf.setImage(with: url)
    }
    static func nib() -> UINib {
        return UINib(nibName: "TwoTitleAndAvatarTableViewCell", bundle: nil)
    }
    
}
