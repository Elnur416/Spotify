//
//  NetworkManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation
import Alamofire

typealias Empty = Alamofire.Empty

final class NetworkManager {
    func request<T: Codable>(path: String,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url,
                             completion: @escaping ((T?, String?) -> Void)) {
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            AF.request(path,
                       method: method,
                       parameters: params,
                       encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                       headers: headers).responseDecodable(of: model.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
}
