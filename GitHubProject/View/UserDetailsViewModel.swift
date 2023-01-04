//
//  UserDetailsViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 04/01/2023.
//

import Foundation
import UIKit

class UserDetailsViewModel {
    private var user: GitHubUser
    var shouldRefreahUI = Dynamic<Bool>(value: false)


    init(user: GitHubUser) {
        self.user = user
    }
    
    func fetchUsersData() {
        ApiGitHub.shared.getUserDetails(login: user.login ?? "") { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.user = data
                self?.shouldRefreahUI.value = true
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
}
