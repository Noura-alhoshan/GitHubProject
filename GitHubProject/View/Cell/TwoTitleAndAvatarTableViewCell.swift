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
        self.firstTitle?.text = representable.firstTitle
        self.secondTitle?.text = representable.secondTitle
        let url = URL(string:representable.avatar)
        self.avatar?.kf.setImage(with: url)
//        let data = try? Data(contentsOf: url)
//        avatar.image = UIImage(data: data)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TwoTitleAndAvatarTableViewCell", bundle: nil)
    }
    
}
