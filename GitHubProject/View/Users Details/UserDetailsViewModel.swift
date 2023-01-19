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
    var didUsersDetailsLoad = Dynamic<GitHubUser?>(value: nil)
    var isloading = Dynamic<Bool>(value: false)
    var didReposDataLoad = Dynamic<Bool>(value: false)
    var gitRepos = [GitHubRepo]()
    
    init(user: GitHubUser) {
        self.user = user
    }
    
    var rowsNumber: Int {
        return gitRepos.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> GitHubRepo {
        return gitRepos[indexPath.row]
    }
    
    // MARK: - Network
    func getUsersDetails() { 
        isloading.value = true
        ApiGitHub.shared.getUserDetails(login: user.login ?? "") { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.user = data
                self?.didUsersDetailsLoad.value = data
                self?.isloading.value = false
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func getReposData() {
        ApiGitHub.shared.getRepoDetails(login: user.login ?? "") { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.gitRepos = data
                self?.didReposDataLoad.value = true
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
}
