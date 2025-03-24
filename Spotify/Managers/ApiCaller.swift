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
        static let baseURL = "https://api.spotify.com/v1/me"
    }
    
    private func getCurrentUserProfile(completion: @escaping ((UserProfile?, String?) -> Void)) {
        createRequest(url: URL(string: "")) { baseRequest in
            
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
