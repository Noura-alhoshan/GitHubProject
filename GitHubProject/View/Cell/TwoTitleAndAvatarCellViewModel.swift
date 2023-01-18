//
//  TwoTitleAndAvatarCellViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 18/01/2023.
//

import Foundation

struct TwoTitleAndAvatarCellViewModel {
    var avatar: String
    var title: String
    
    init(avatar: String, title: String) {
        self.avatar = avatar
        self.title = title
    }
}
