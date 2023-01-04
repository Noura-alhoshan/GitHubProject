//
//  ApiGitHub.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation

class ApiGitHub {
    
    static var shared = ApiGitHub()
    
    private var dataTask: URLSessionDataTask?
    
    func getGitHubUsersURL(completion: @escaping (Result<[GitHubUser], Error>) -> Void) {
        
        let gitHubURL = "https://api.github.com/users"
        
        guard let url = URL(string: gitHubURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([GitHubUser].self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
        
    func getUserDetails(login: String, completion: @escaping (Result<GitHubUser, Error>) -> Void) {

        let userDetails = "https://api.github.com/users/\(login)"

        guard let url = URL(string: userDetails) else {return}

        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GitHubUser.self, from: data)

                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
    }
    
    func getRepoDetails(reposURL: String, completion: @escaping (Result<GitHubRepo, Error>) -> Void) {

        let repoDetails = reposURL

        guard let url = URL(string: repoDetails) else {return}

        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GitHubRepo.self, from: data)

                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
    }
}
