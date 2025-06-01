//
//  NetworkManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation
import Alamofire

typealias Empty = Alamofire.Empty
struct EmptyResponse: Codable {}

final class NetworkManager {
    func request<T: Codable>(path: String,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url) async throws -> T? {
        
        let token = try await AuthManager.shared.validToken()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(path,
                       method: method,
                       parameters: params,
                       encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                       headers: headers).responseDecodable(of: model) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
