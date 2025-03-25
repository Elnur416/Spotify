//
//  ApiCaller.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    func getCurrentUserProfile(completion: @escaping ((UserProfile?, String?) -> Void)) {
        createRequest(url: URL(string: Constants.baseAPIURL + "/me")) { baseRequest in
            guard let baseRequest = baseRequest else { return }
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(nil, error?.localizedDescription)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(result, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    private func createRequest(url: URL?,
                               type: HTTPMethod? = .get,
                               completion: @escaping ((URLRequest?) -> Void)) {
        guard let apiURL = url else { return }
        AuthManager.shared.withValidToken { token in
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type?.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
