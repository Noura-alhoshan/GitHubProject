//
//  ApiGitHub.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 03/01/2023.
//

import Foundation

// url should change : done
class ApiGitHub {
    
   static var shared = ApiGitHub()
    
    var baseURL: URL {
         return URL(string: "https://api.github.com")!
     }
    
    enum path: String {
        case users = "/users"
        case repository = "/repos"
    }
    
    private var dataTask: URLSessionDataTask?
    
    func getGitHubUsersURL(completion: @escaping (Result<[GitHubUser], Error>) -> Void) {
                
        guard let url = URL(string: path.users.rawValue, relativeTo: baseURL) else {return}
        
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
        
        guard let url = URL(string: path.users.rawValue + "/\(login)", relativeTo: baseURL ) else {return}

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
    
    func getRepoDetails(login: String, completion: @escaping (Result<[GitHubRepo], Error>) -> Void) {

        guard let url = URL(string: path.users.rawValue + "/\(login)" + path.repository.rawValue, relativeTo: baseURL) else {return}

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
                let jsonData = try decoder.decode([GitHubRepo].self, from: data)

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
    func getRepoForkUsers(forkUrl: String, completion: @escaping (Result<[GitHubRepo], Error>) -> Void) {

        guard let url = URL(string: forkUrl) else {return}

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
                let jsonData = try decoder.decode([GitHubRepo].self, from: data)

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
