//
//  TwoTitleAndAvatarCellViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 18/01/2023.
//

import Foundation

struct TwoTitleAndAvatarCellViewModel {
    var avatar: String
    var firstTitle: String
    var secondTitle: String
    
    init(avatar: String, firstTitle: String, secondTitle: String ) {
        self.avatar = avatar
        self.firstTitle = firstTitle
        self.secondTitle = secondTitle
    }
}
