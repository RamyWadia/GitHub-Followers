//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-24.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getFollower(for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let urlString = baseUrl + "/users/\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder                  = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                let followers                = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getUser(for userName: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let urlString = baseUrl + "/users/\(userName)"
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cashKey = NSString(string: urlString)
        if let image = cache.object(forKey: cashKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
        completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            self.cache.setObject(image, forKey: cashKey)
                completed(image)
        }
        task.resume()
    }
    
}
