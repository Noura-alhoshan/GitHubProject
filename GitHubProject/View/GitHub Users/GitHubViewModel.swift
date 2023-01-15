//
//  GitHubViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation

class GitHubViewModel {
    
    var didUsersLoad = Dynamic<Bool>(value: false)
    var isloading = Dynamic<Bool>(value: true)


    var gitUsers = [GitHubUser]() {
        didSet {
            didUsersLoad.value = true
            isloading.value = false
        }
    }
    
    var rowsNumber: Int {
        return gitUsers.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> GitHubUser {
        return gitUsers[indexPath.row]
    }
    
    // MARK: - Network
    func getUsersData() {
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
