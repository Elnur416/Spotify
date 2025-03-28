//
//  ApiCaller.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation
import Alamofire

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    func getCurrentUserProfile(completion: @escaping ((UserProfile?, String?) -> Void)) {
        guard let url = URL(string: Constants.baseAPIURL + "/me") else {
            completion(nil, "Invalid URL")
            return
        }
        
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            
            AF.request(url,
                       method: .get,
                       headers: headers)
                .responseDecodable(of: UserProfile.self) { response in
                    switch response.result {
                    case .success(let result):
                        completion(result, nil)
                    case .failure(let error):
                        completion(nil, error.localizedDescription)
                    }
                }
        }
    }
}
