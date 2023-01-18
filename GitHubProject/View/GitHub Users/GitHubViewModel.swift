//
//  GitHubViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation

class GitHubViewModel {
    
    var didUsersLoad = Dynamic<Bool>(value: false)
    var isloading = Dynamic<Bool>(value: false)


    var gitUsers = [GitHubUser]() {
        didSet {
            didUsersLoad.value = true
            isloading.value = false
        }
    }
    
    var rowsNumber: Int {
        return gitUsers.count
    }
    
    func getUser(indexPath: IndexPath) -> GitHubUser {
        return gitUsers[indexPath.row]
    }
    
    func cellViewModel(indexPath: IndexPath) -> TwoTitleAndAvatarCellViewModel {
        let user = gitUsers[indexPath.row]
        let cellViewModel = TwoTitleAndAvatarCellViewModel(avatar: user.avatarURL ?? "", title: user.login ?? "")
        return cellViewModel
    }
    
    
    // MARK: - Network
    func getUsersData() {
        isloading.value = true
        ApiGitHub.shared.getGitHubUsersURL { [weak self] (result) in
            switch result {
            case .success(let users1):
                self?.gitUsers = users1
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
}
