//
//  GitHubViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation

class GitHubViewModel {
    
    var gitUsers = [GitHubUser]()
    
    func getUsersData(completion: @escaping () -> ()) {
        ApiGitHub.shared.getGitHubUsersURL { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.gitUsers = listOf.users
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
