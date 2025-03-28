//
//  AuthManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation
import Alamofire

final class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    private init() {}
    
    //    MARK: Constants
    
    struct Constants {
        static let clientID = "7e46395e26344145a47cb7a203421ede"
        static let clientSecret = "8b2783c39eeb4586bdb67c05de0a9f67"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://open.spotify.com"
        static let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    //    MARK: - SignIn URL
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    //    MARK: - Should Refresh Token
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    //    MARK: - Get Token
    
    func exchangeCodeForToken(code: String, completion: @escaping((Bool) -> Void)) {
        let url = Constants.tokenAPIURL
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": Constants.redirectURI,
            "client_id": Constants.clientID
        ]
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)!
        let base64String = data.base64EncodedString()
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64String)"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let result):
                    self.cacheToken(result: result)
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                }
            }
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    func withValidToken(completion: @escaping ((String) -> Void)) {
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
//    MARK: - Refresh Token
    
    func refreshIfNeeded(completion: @escaping ((Bool) -> Void)) {
        guard !refreshingToken else { return }
        
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else { return }
        
        let url = Constants.tokenAPIURL
        refreshingToken = true
        
        let parameters: [String: String] = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)!
        let base64String = data.base64EncodedString()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64String)"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { [weak self] response in
                self?.refreshingToken = false
                
                switch response.result {
                case .success(let result):
                    self?.onRefreshBlocks.forEach { $0(result.accessToken ?? "") }
                    self?.onRefreshBlocks.removeAll()
                    self?.cacheToken(result: result)
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                }
            }
    }
    
    //    MARK: - Cache Token
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken,
                                       forKey: "accessToken")
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue(refreshToken,
                                           forKey: "refreshToken")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn ?? 0)),
                                       forKey: "expirationDate")
    }
}
