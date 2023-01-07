//
//  ForksUsersViewModel.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 05/01/2023.
//

import Foundation
class ForksUsersViewModel {
    private var forkUser: GitHubRepo
    var shouldRefreahUI = Dynamic<Bool>(value: false)
    var isloading = Dynamic<Bool>(value: false)
    var allForksUsers = [GitHubRepo]()

    init(forkUser: GitHubRepo) {
        self.forkUser = forkUser
    }
    
    var rowsNumber: Int {
        return allForksUsers.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> GitHubRepo {
        return allForksUsers[indexPath.row]
    }
    
    func getForksUsersData(completion: @escaping () -> ()) {
        isloading.value = true
        ApiGitHub.shared.getRepoForkUsers(forkUrl: forkUser.forksURL ?? "") { [weak self] (result) in
            self?.isloading.value = false
            switch result {
            case .success(let data):
                self?.allForksUsers = data
                self?.shouldRefreahUI.value = true
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
