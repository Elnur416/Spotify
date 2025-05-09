//
//  TrackUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation

protocol TrackUseCase: AnyObject {
    func saveTrack(id: String, completion: @escaping ((Empty?, String?) -> Void))
}
