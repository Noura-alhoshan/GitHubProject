//
//  GitHubViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation

class GitHubViewModel {
    
    var gitUsers = [GitHubUser]()
    var shouldRefreahUI = Dynamic<Bool>(value: false)

    func getUsersData(completion: @escaping () -> ()) {
        ApiGitHub.shared.getGitHubUsersURL { [weak self] (result) in
            switch result {
            case .success(let users1):
                self?.gitUsers = users1
                self?.shouldRefreahUI.value = true
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func cellForRowAt (indexPath: IndexPath) -> GitHubUser {
        return gitUsers[indexPath.row]
    }
    
    
}
