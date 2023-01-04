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
    var shouldRefreahUIforRepo = Dynamic<Bool>(value: false)
    var gitRepos = [GitHubRepo]()
    
    
    init(user: GitHubUser) {
        self.user = user
    }
    
    var follwers: String {
        let x : Int = user.followers ?? 00
        let xNSNumber = x as NSNumber
        let xString : String = xNSNumber.stringValue
        return xString
    }
    var publicRepo: String {
        let x : Int = user.publicRepos ?? 00
        let xNSNumber = x as NSNumber
        let xString : String = xNSNumber.stringValue
        return xString
    }
    
    var rowsNumber: Int {
        return gitRepos.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> GitHubRepo {
        return gitRepos[indexPath.row]
    }
    
    func getUsersDetails() {
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
    
    func getReposData(completion: @escaping () -> ()) {
        
        ApiGitHub.shared.getRepoDetails(login: user.login ?? "") { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.gitRepos = data
                self?.shouldRefreahUIforRepo.value = true
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
}
