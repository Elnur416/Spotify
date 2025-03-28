//
//  NetworkHelper.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
}

final class NetworkHelper {
    static let shared = NetworkHelper()
    
    private init() {}
    
    let baseAPIURL = "https://api.spotify.com/v1"
}
